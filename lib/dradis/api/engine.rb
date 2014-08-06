module Dradis
  module API
    class Engine < ::Rails::Engine
      # Standard Rails Engine stuff
      isolate_namespace Dradis

      # use rspec for tests
      config.generators do |g|
        g.test_framework :rspec
      end

      # Connect to the Framework
      include Dradis::Plugins::Base

      provides :addon
      description 'Expose an HTTP API under /api/'

      # No need to initialize anything in this case
      initializer "dradis-api.inflections" do |app|
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.acronym('API')
        end
      end

      # Register a new Warden strategy for API authentication
      initializer 'dradis-api.warden' do |app|
        Warden::Strategies.add(:api_auth, Dradis::API::WardenStrategy)
      end

    end
  end
end