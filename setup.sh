adduser deploy
adduser deploy sudo
exit


sudo apt update
sudo apt upgrade
sudo apt install curl git zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev gcc g++ make autoconf automake libtool bison gnupg apt-transport-https ca-certificates

# yarn and nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn # this command install nodejs also

# fullstaqruby
nano /etc/apt/sources.list.d/fullstaq-ruby.list
deb https://apt.fullstaqruby.org ubuntu-20.04 main

curl -SLfO https://raw.githubusercontent.com/fullstaq-labs/fullstaq-ruby-server-edition/main/fullstaq-ruby.asc
sudo apt-key add fullstaq-ruby.asc
sudo apt update
sudo apt install fullstaq-ruby-common
sudo apt search fullstaq-ruby
# This will auto-update to the latest tiny version when it's released
sudo apt install fullstaq-ruby-2.7

echo 'export PATH="/usr/lib/fullstaq-ruby/versions/2.7/bin/:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
rbenv rehash
rbenv global 2.7


# # rbenv
# cd ~
# git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# exec $SHELL

# git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# exec $SHELL

# rbenv rehash
# #rbenv install -l # list versions
# rbenv install 2.7.2
# rbenv global 2.7.2
# ruby -v

# gem install bundler



# nginx
sudo apt install nginx
# nginx -------------------------------------------- START
sudo nano /etc/nginx/sites-available/default
# ====================================
upstream puma {
    server unix:/home/deploy/trends/shared/sockets/puma.sock fail_timeout=0;
}

server {
    listen 80 default_server deferred;
    server_name genuinetrends.com www.genuinetrends.com;

    root /home/deploy/trends/current/public;

    location ~ ^/(assets|packs)/ {
        gzip_static on;
        expires 24h;
        add_header Cache-Control public;
    }

    try_files $uri/index.html $uri @app;
    location @app {
        proxy_pass http://puma;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_redirect off;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 5M;
    keepalive_timeout 5;
}
# ====================================
# nginx -------------------------------------------- END
nginx -t # Test to make sure the new config file is working
sudo systemctl reload nginx
sudo systemctl status nginx


# gemfile
gem "rack-timeout"

# puma.rb
# -------------------------------------------------------------------
# Change to match your CPU core count (require memory)
workers 1

# Min and Max threads per worker (require cpu)
threads 3, 6

preload_app!

app_dir = File.expand_path("../..", __FILE__)
shared_dir "#{app_dir}/shared"

port ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }

bind "unix://#{shared_dir}/tmp/sockets/puma.sock"

stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

pidfile "#{shared_dir}/tmp/pids/puma.pid"
state_path "#{shared_dir}/tmp/pids/puma.state"

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
# -------------------------------------------------------------------

# gemfile
group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end