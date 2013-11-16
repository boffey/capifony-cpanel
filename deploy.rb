set :application, "My Application"
set :domain,      "my-app.com"
set :deploy_to,   "/home/cpanel-username/my-app"
set :app_path,    "app"

set :repository,  "ssh-gitrepo-domain.com:/path/to/repo.git"
set :scm,         :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, or `none`

# Restrict Capistrano to the master branch useful when working with gitflow etc.
# set :branch, "master"

set :user, "cpanel-username"  # The server's user for deploys

# Don't use sudo as we cPanel users are not in the sudoers file.
set :use_sudo, false

set :deploy_via, :remote_cache
set :shared_files, ["app/config/parameters.yml"]
set :shared_children, [app_path + "/logs", web_path + "/uploads", "vendor"]

set :use_composer, true
set :update_vendors, true
set :composer_options, "--no-dev --verbose --prefer-dist --optimize-autoloader"

set :model_manager, "doctrine"
# Or: `propel`

role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain, :primary => true       # This may be the same as your `Web` server

set  :keep_releases,  3

# Be more verbose by uncommenting the following line
# logger.level = Logger::MAX_LEVEL

# cPanel has a restrcition that files cannot be group writable this works the way up the directory strcuture and corrects this.
desc "Update Permissions for cPanel Restrictions"
after 'deploy:update_code' do
	run "chmod 644 #{release_path}/web/app.php"
	run "chmod 755 #{release_path}/web"
	run "chmod 755 #{release_path}"
	run "chmod 755 #{deploy_to}/releases"
	run "chmod 755 #{deploy_to}"
end