# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module WeatherApp
  class Application < Rails::Application
    config.load_defaults 6.1
    config.generators.system_tests = nil
  end
end
