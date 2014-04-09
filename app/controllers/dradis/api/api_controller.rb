module Dradis
  module API
    class APIController < AuthenticatedController
      after_filter :skip_set_cookies_header

      protected

      # See:
      #   http://railscasts.com/episodes/352-securing-an-api
      def login_from_token
        authenticate_with_http_token do |token, options|
          # We don't have the concept of users in Dradis!
          # User.find_by_api_token(token)
        end
      end

      # First try to load using the API token, then use @super@ for HTTP Basic
      # fallback
      def current_user
        # super
        # @current_user ||= login_from_token || login_from_basic_auth
        @current_user ||= login_from_token || super
      end


      # ---------------------------------------------------------- Authentication
      # In API controllers, render 401 and a JSON body instead of the default
      # defined in ApplicationController

      def access_denied
        respond_to do |format|
          format.json do
            render json: {message: 'Requires authentication'}, status: :unauthorized
          end
        end
      end
      def login_required
        !!current_user || access_denied
      end


      # ----------------------------------------------------------- Avoid cookies
      # In API controllers, we don't need to set any cookies (i.e. remove
      # Set-Cookie headers).
      def skip_set_cookies_header
        request.session_options[:skip] = true
      end
    end
  end
end