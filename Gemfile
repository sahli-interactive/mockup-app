source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv-rails', '>= 2.7.5'
gem 'inline_svg'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.4.1'
gem 'rails-i18n'
gem 'redis', '~> 4.0'

gem 'sidekiq', '~> 6.0', '>= 6.0.3'
gem 'sprockets', '~> 3.7.2'
gem 'unpoly-rails'
gem 'webpacker', "~> 4.0"
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'annotate', '>= 2.5.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails_real_favicon'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'mailgunner'
  gem 'rack-cache', require: 'rack/cache'
end
