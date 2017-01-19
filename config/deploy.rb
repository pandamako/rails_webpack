set :application, "rails_webpack"
set :repo_url, "git@github.com:Sfolt/rails_webpack.git"
set :user, "d"
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

before 'deploy:assets:precompile', 'deploy:npm_install'

namespace :deploy do
  desc 'Run npm install'
  task :npm_install do
    on roles :app do
      execute "cd #{release_path} && npm install && webpack build"
      # execute "cd #{release_path} && bundle exec rake webpack:compile"
    end
  end
end

after 'deploy:finishing', 'deploy:cleanup'
after 'deploy:publishing', 'unicorn:restart'
