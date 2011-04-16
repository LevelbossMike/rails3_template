# references for Rails3 template syntax: 
# http://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
# http://rdoc.info/github/wycats/thor/master/Thor/Actions
# Directories for template partials and static files
@template_root = File.expand_path(File.join(File.dirname(__FILE__)))
#@partials     = File.join(@template_root, 'partials')
#@static_files = File.join(@template_root, 'files')



# compass -> compass-style.org
gem 'compass', '>= 0.11.beta.7'
gem 'haml-rails'
# require newest haml compass beta depends on it
gem 'haml', '>= 3.1.alpha.214'

# change to jquery
gem "jquery-rails"

# development group
gem 'rspec-rails', '2.5.0', :group => :development

# test group
gem 'rspec', '2.5.0', :group => :test
gem 'webrat', '0.7.1', :group => :test
gem 'autotest', '4.4.6', :group => :test
gem 'autotest-rails-pure', '4.1.2', :group => :test
gem 'autotest-fsevent', '0.2.4', :group => :test
gem 'autotest-growl', '0.2.9', :group => :test
gem 'spork', '0.9.0.rc4', :group => :test

# create rvmrc file; use current ruby
current_ruby = %x{rvm list}.match(/^=>\s+(.*)\s\[/)[1].strip
create_file ".rvmrc", "rvm #{current_ruby}@#{app_name}"
run "rvm gemset create #{app_name}"
run "rvm #{current_ruby}@#{app_name} gem install bundler"
run "rvm #{current_ruby}@#{app_name} -S bundle install"

generate "jquery:install"
# run "rails generate jquery:install"
generate "rspec:install"
inside "#{app_name}" do
  run "spork --bootstrap"
end
# create .autotest
copy_file "#{@template_root}/autotest", ".autotest"
# additions for spork
copy_file "#{@template_root}/spec_helper.rb", "spec/spec_helper.rb"

# initialize git repository
git :init

# add the whole app (rails 3 generates a .gitignore file
# automatically, unless  --skip-git is specified)
git :add => '.'

# and commit the empty app
git :commit => "-m 'initial commit'"

