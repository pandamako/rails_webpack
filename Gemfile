source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
gem 'sqlite3'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'webpack-rails'

gem 'foreman'
gem 'unicorn'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-file-permissions', require: false, github: 'morr/file-permissions'
  gem 'rvm1-capistrano3', require: false
  gem 'airbrussh', require: false
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-spring', require: false
  gem 'guard-pow', require: false
  gem 'guard-rubocop', require: false
end

group :test do
  gem 'factory_girl_rails', require: false
  gem 'factory_girl-seeds', require: false
  gem 'timecop'
  gem 'webmock'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
