# Change to match your CPU core count (require memory)
workers 1

# Min and Max threads per worker (require cpu)
threads 3, 10

preload_app!

shared_dir "/home/deploy/trends/shared"

port ENV.fetch("PORT") { 3000 }
environment 'production'

bind "unix://#{shared_dir}/tmp/sockets/puma.sock"

stdout_redirect "#{shared_dir}/log/puma_access.log", "#{shared_dir}/log/puma_error.log", true

pidfile "#{shared_dir}/tmp/pids/puma.pid"
state_path "#{shared_dir}/tmp/pids/puma.state"

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
