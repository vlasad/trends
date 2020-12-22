# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

# Change these
server '45.76.23.202', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:vlasad/trends.git'
set :application,     'trends'

set :user,            'deploy'

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/deploy/trends"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/vlasad.pub) }
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 3

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs,  %w{db/prod log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads public/packs}

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2'

set :rails_env, 'production'
set :keep_assets, 2

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        upload! 'config/master.key', "#{shared_path}/config/master.key"
        upload! 'config/database.yml', "#{shared_path}/config/database.yml"
        upload! 'config/puma_prod.rb', "#{shared_path}/puma.rb"
      end
    end
  end
end