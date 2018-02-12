source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', github: 'rails/rails'
gem 'sqlite3'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

