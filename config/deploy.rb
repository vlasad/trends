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
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads public/packs}

set :rails_env, 'production'
set :keep_assets, 2
