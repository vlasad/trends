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
