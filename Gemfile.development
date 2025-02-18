source 'http://rubygems.org'
ENV['RAILS_ENV'] ||= 'development'

gem 'rails' #, '> 7.1'
gem 'activeresource'

gem 'activerecord-enhancedsqlite3-adapter'
#gem "activerecord-trilogy-adapter"

gem 'activerecord-session_store'

gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'sprockets'
# gem 'sassc'

gem 'jquery-rails'
gem 'jquery-ui-rails'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

#gem 'exception_notification'

gem 'rb-readline'
gem 'bootsnap', require: false
gem 'spreadsheet'
gem 'prawn'
gem 'prawn-table'
gem 'matrix'
gem 'kaminari'
gem 'net-http'
gem 'drg_material_icons'
gem 'mini_magick'

if ENV['RAILS_ENV'] == 'development' || ENV["RAILS_ENV"] == "test"
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'puma'
  gem 'byebug'
  gem 'listen'
  gem 'rubocop', require: false
  gem 'web-console'

  gem 'agile_rails', :path => '../agile_rails'
  gem 'agile_rails_html_editor', path: '../agile_rails_html_editor'
  gem 'agile_rails_orders', path: '../agile_rails_orders'

  # gem 'my_own_gem', path: '../to_my_own_gem'

else #PRODUCTION
  gem 'agile_rails'
  gem 'agile_rails_html_editor', git: 'https://github.com/agile-rails/agile-rails-html-editor'
  gem 'agile_rails_orders', git: 'https://github.com/agile-rails/agile-rails-orders'

  #source "http://my.gems.server" do
  #  gem 'my_own_gem'
  #end
end

#gem 'agile_rails_html_editor', git: 'https://github.com/agile-rails/agile-rails-html-editor'
#gem 'agile_rails_orders', git: 'https://github.com/agile-rails/agile-rails-orders'


if ENV["RAILS_ENV"] == "test"
  gem 'minitest'
  gem 'capybara'
  gem 'selenium-webdriver'
end
