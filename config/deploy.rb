set :application, "rails_webpack"
set :repo_url, "git@github.com:Sfolt/rails_webpack.git"
set :user, "roller"
set :group, 'apps'
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
set :linked_files, %w{
  config/secrets.yml
}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets tmp/sessions public/system}

def npm_exec command
  execute "cd #{release_path} && NODE_ENV=#{fetch :rails_env} #{command}"
end
def bundle_exec command
  execute "sudo -u roller -H zsh -l -c \"source /home/roller/.rvm/scripts/rvm && cd #{release_path} && RAILS_ENV=#{fetch :rails_env} bundle exec #{command}\""
end

namespace :deploy do
  desc 'Run npm install'
  task :npm_install do
    on roles :app do
      dir = 'public/webpack'
      execute "sudo mkdir -p #{release_path}/#{dir}"
      execute "sudo chown #{fetch :user}:#{fetch :group} #{release_path}/#{dir}"

      npm_exec 'npm install'
      npm_exec 'webpack build'
      bundle_exec 'rake webpack:compile'
    end
  end
end

before 'deploy:assets:precompile', 'deploy:npm_install'
after 'deploy:finishing', 'deploy:cleanup'
# after 'deploy:publishing', 'unicorn:restart'
