source 'http://rubygems.org'
ENV['RAILS_ENV'] ||= 'development'

gem 'rails'#, '> 7.1'
gem 'sqlite3'#, '< 2'
#gem "activerecord-trilogy-adapter"
gem 'activerecord-enhancedsqlite3-adapter'
gem 'activeresource'
gem 'activerecord-session_store'

gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'sprockets'
gem 'sassc'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'bcrypt' #, '~> 3.0.0'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

#gem 'exception_notification'

gem 'rb-readline'                 # needed for rails c(onsole)
gem 'bootsnap', require: false
gem 'spreadsheet'
gem 'prawn'
gem 'prawn-table'
gem 'matrix'
gem 'kaminari'
gem 'net-http'
gem 'drg_material_icons'

#if ENV['RAILS_ENV'] == 'development' || ENV["RAILS_ENV"] == "test" ||
#   ENV["RAILS_ENV"] == "stage" || ENV["RAILS_ENV"] == "source" || ENV["RAILS_ENV"] == "destination"

if ENV['RAILS_ENV'] == 'development' || ENV["RAILS_ENV"] == "test"
  gem 'spring'
  gem 'spring-watcher-listen'#, '~> 2.0.0'
  gem 'puma'
  gem 'byebug'
  gem 'listen'
  gem 'rubocop', require: false

  gem 'agile_rails', :path => '../agile_rails'
  gem 'agile_rails_html_editor', path: '../agile_rails_html_editor'

else #PRODUCTION
  gem 'agile_rails', :path => '../agile_rails'
  gem 'agile_rails_html_editor', :path => '../agile_rails_html_editor'

  #source "http://my.gems.server" do
  #  gem 'my_own_gem'
  #end
end

gem "agile_rails_orders", git: 'https://github.com/agile-rails/agile-rails-orders'

if ENV["RAILS_ENV"] == "development" || ENV["RAILS_ENV"] == "test"
  gem 'web-console'
  #  gem 'agile_rails_orders',        :path => '../agile_rails_orders'
  #  gem 'my_own_gem', path: '../to_my_own_gem'
end

if ENV["RAILS_ENV"] == "test"
  gem 'minitest'
  gem 'capybara'
  gem 'selenium-webdriver'
end
