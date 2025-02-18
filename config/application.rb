require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

Agile.add_forms_path(File.expand_path("../../app/forms", __FILE__))
Agile.add_forms_path(File.expand_path("../../app/reports/forms", __FILE__))

#Agile.config(:default_labels_position, 'left')  # top, left
#Agile.config(:default_actions_position, 'top') # top, bottom, both

#Agile.config(:index_standard_actions, { 1 => 'new', 2 => 'filter', 3 => 'sort' })
#Agile.config(:dataset_standard_actions, { 1 => 'edit', 2 => 'duplicate', 3 => 'delete' })
#Agile.config(:form_standard_actions, { 1 => 'back', 2 => 'save', 3 => 'save&back', 4 => 'refresh', 5 => 'enable', 6 => 'new' })
