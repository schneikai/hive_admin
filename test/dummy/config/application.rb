require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)
require "hive_admin"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # TODO
    # In the dummy app the ActiveAdmin load path was "test/dummy/app/admin" but
    # we need "app/admin" instead. I think this is only necessary in the dummy app
    # because when the engine is included in a regular app the load path should
    # automatically be "app/admin".
    # We moved the resources to lib and added the new laod path in engine.rb so
    # I don't think this is necessary anymore...
    # initializer :active_admin do
    #   ActiveAdmin.application.load_paths << HiveAdmin::Engine.root.join('app', 'admin')
    # end
  end
end

