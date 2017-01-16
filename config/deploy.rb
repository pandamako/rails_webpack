# config valid only for current version of Capistrano
# lock "3.7.1"

set :application, "rails_webpack"
set :repo_url, "git@github.com:Sfolt/rails_webpack.git"
# https://github.com/Sfolt/rails_webpack.git

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


set :user, "d"
#set :branch, ->{ `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, "master"
set :repo_name, 'rails_webpack'

set :ssh_options, {:forward_agent => true}

set :rails_env, fetch(:stage)
set :rvm1_ruby_version, 'ruby-2.3.1'

set :keep_releases, 3
set :format, :pretty
set :use_sudo, false
set :deploy_via, :copy

set :unicorn_conf, "#{deploy_to}/current/config/unicorn/production.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :bundle_without, [:development, :test]

set :linked_files, %w{
  config/secrets.yml
}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets tmp/sessions public/system}

namespace :assets do
  task :precompile do
    run "cd #{release_path}; rake assets:precompile RAILS_ENV=production"
  end
end

# before "deploy:assets:precompile", "test1:test2"

# namespace :test1 do
  # task :test2 do
    # 1/0
  # end
# end

before 'deploy:assets:precompile', 'deploy:yarn_install'

namespace :deploy do
  desc 'Run npm install'
  task :yarn_install do
    on roles :app do
      execute 'cd #{release_path} && nvm install v6.9.1 && yarn add webpack && yarn install && webpack build'
    end
  end
end

# namespace :deploy do
  # task :restart do
    # run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  # end
  # task :start do
    # run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  # end
  # task :stop do
    # run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  # end
# end

# after 'deploy:finishing', 'deploy:cleanup'
# after 'deploy:publishing', 'unicorn:restart'

