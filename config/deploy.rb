# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'testapp'
# set :repo_url, 'git@github.com:AndriykoSTU/post.git'
set :repo_url, 'git@github.com:tyler-mf/post.git'
set :branch,    'master'

set :user, 'testuser'
set :tmp_dir, "/tmp"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}

set :keep_releases, 1

set :use_sudo,         false
set :rvm_type,         :user
set :rvm_ruby_version, '2.1.3'
set :rvm_custom_path,  '/home/testuser/.rvm'
set :stage,     :production
set :deploy_to, '/home/testuser/testapp'
set :unicorn_config_path, "/home/testuser/testapp/config/unicorn.rb"




# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
  Rake::Task['deploy:assets:precompile'].clear
 

namespace :assets do
desc 'Precompile assets locally and then rsync to remote servers'
task :precompile do
local_manifest_path = %x{ls public/assets/manifest*}.strip
 
%x{bundle exec rake assets:precompile assets:clean}
 
on roles(fetch(:assets_roles)) do |server|
%x{rsync -av ./public/assets/ #{server.user}@#{server.hostname}:#{release_path}/public/assets/}
%x{rsync -av ./#{local_manifest_path} #{server.user}@#{server.hostname}:#{release_path}/assets_manifest#{File.extname(local_manifest_path)}}
end
 
%x{bundle exec rake assets:clobber}
end
end
end

