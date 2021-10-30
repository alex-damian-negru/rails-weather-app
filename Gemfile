# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bootsnap', '~> 1.9'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4.1'
gem 'sass-rails', '~> 6.0'

group :development, :test do
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'guard-rubocop', '~> 1.4'
  gem 'pry-byebug', '~> 3.9', platform: :mri
  gem 'rubocop', '~> 1.22'
  gem 'rubocop-performance', '~> 1.11.5'
  gem 'rubocop-rails', '~> 2.12.4'
  gem 'rubocop-rspec', '~> 2.5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring', '~> 3.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0.1'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'rspec-its', '~> 1.3'
  gem 'rspec-rails', '~> 5.0.2'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
