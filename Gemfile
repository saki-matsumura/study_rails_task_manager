source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "rails", "~> 6.1.6"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"

gem "bootsnap", ">= 1.4.4", require: false

# 追加：Heroku用
gem "net-smtp"
gem "net-imap"
gem "net-pop"
gem "faker"  # 移動：Herokuでフェイカーを使用できるようにする

# 追加：enum用
gem 'enum_help'

# 追加：ページテーション
gem 'kaminari'

# 追加：ログインシステム
gem 'bcrypt'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]

  gem "rspec-rails"
  gem "spring-commands-rspec"
  gem "factory_bot_rails"
  # gem "faker"
  gem "launchy"
  # テストデバッグ
  # gem "pry-rails"
end

group :development do
  gem "web-console", ">= 4.1.0"
  # gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  gem "spring"
  # 追加：デバッグ用
  gem "pry-rails"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
