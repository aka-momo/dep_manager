source 'https://rubygems.org'

# Specify your gem's dependencies in dep_manager.gemspec
gemspec

gem 'rake', '~> 12.0'
gem 'rspec', '~> 3.5.0'
gem 'simplecov', '~> 0.10'

local_gemfile = 'Gemfile.local'
eval_gemfile local_gemfile if File.exist?(local_gemfile)