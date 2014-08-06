# Dradis::API::WardenStrategy
#
# HTTP Basic authentication strategy for Warden.
#
# See:
#   https://github.com/hassox/warden
#
module Dradis
  module API
    class WardenStrategy < ::Warden::Strategies::Base

      # This strategy should be applied when we are requesting /api/
      def valid?
        !!(request.path_info =~ /\A\/api\//)
      end

      def authenticate!
        if auth.provided? && auth.basic? && auth.credentials
          username = auth.credentials.first
          password = auth.credentials.last

          if not ( username.blank? || password.nil? || ::BCrypt::Password.new(Dradis::Core::Configuration.password) != password )
            success!(username)
          else
            custom!(unauthorized(403))
          end
        else
          custom!(unauthorized(401))
        end
      end

      private
      def auth
        @auth ||= Rack::Auth::Basic::Request.new(env)
      end
      def unauthorized(status=401)
        [
          status,
          {
            'Content-Type' => 'text/plain',
            'Content-Length' => '0',
            'WWW-Authenticate' => %(Basic realm="realm")
          },
          []
       ]
      end
    end
  end
end
