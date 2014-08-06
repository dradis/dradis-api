module Dradis
  module API
    class APIController < Dradis::Frontend::AuthenticatedController
      after_filter :skip_set_cookies_header

      protected
      # ---------------------------------------------------------- Authentication
      # In API controllers, render 401 and a JSON body instead of the default
      # defined in ApplicationController.
      #
      # This action is used as Warden's :failure_app (see engine.rb)

      def access_denied
        respond_to do |format|
          format.json do
            render json: {message: 'Requires authentication'}, status: :unauthorized
          end
        end
      end

      def login_required
        warden.authenticate!(:api_auth)
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