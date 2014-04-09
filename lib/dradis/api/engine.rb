module Dradis
  module API
    class Engine < ::Rails::Engine
      # Standard Rails Engine stuff
      isolate_namespace Dradis
      engine_name 'dradis_api'

      # use rspec for tests
      config.generators do |g|
        g.test_framework :rspec
      end

      # No need to initialize anything in this case
      initializer "dradis.api.inflections" do |app|
        ActiveSupport::Inflector.inflections do |inflect|
          inflect.acronym('API')
        end
      end
    end
  end
end