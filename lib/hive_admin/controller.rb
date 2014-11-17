# Extensions for the host apps ApplicationController.

module HiveAdmin
  module Controller
    extend ActiveSupport::Concern

    # # Authentificates the current user for ActiveAdmin and only allows access
    # # to users with the *admin* role.
    # def authenticate_admin_user!
    #   authenticate_user!
    #   unless true_user.has_role? :admin
    #     flash[:alert] = "This area is restricted to administrators only."
    #     redirect_to root_path
    #   end
    # end

    # # Returns the current user for ActiveAdmin.
    # def current_admin_user
    #   return nil if user_signed_in? && !true_user.has_role?(:admin)
    #   true_user
    # end


    # Returns the current user for ActiveAdmin. Always return *true_user* here
    # because *current_user* might be a impersonated user. See HiveAdmin::Impersonator
    # for more information.
    def current_admin_user
      true_user
    end

    # This method is called on unauthorized access.
    # Send user back to the home page and flash a message.
    def hive_admin_access_denied(exception)
      redirect_to root_path, alert: exception.message
    end

    # Returns a redirect location for member actions by using the a stored
    # location from the session or the referer. If no stored location or
    # referer is present +fallback+ is returned. If no fallback is present
    # +admin_path+ is returned.
    #
    # Example:
    #
    #   member_action :confirm, method: :put do
    #     resource.do_something
    #     redirect_to hive_admin_return_path(resource_path(resource)), notice: "Done somenthing successfully!"
    #   end
    #
    def hive_admin_return_path(fallback=nil)
      if (url = hive_admin_stored_location).present?
        url
      elsif request.referer.present?
        URI(request.referer).request_uri
      elsif fallback.present?
        fallback
      else
        admin_path
      end
    end



    # Provide the ability to store a location.
    # Used to redirect back to a desired path after sign in.
    # This is borrowed from Devise.

    # Returns and delete (if it's navigational format) the url stored in the session for
    # the given scope. Useful for giving redirect backs after sign up:
    #
    # Example:
    #
    #   redirect_to stored_location_for(:user) || root_path
    #
    def hive_admin_stored_location
      session.delete hive_admin_stored_location_key
    end

    # Stores the provided location to redirect the user after signing in.
    # Useful in combination with the `stored_location_for` helper.
    #
    # Example:
    #
    #   store_location_for(:user, dashboard_path)
    #   redirect_to user_omniauth_authorize_path(:facebook)
    #
    def hive_admin_store_location(location)
      if location
        uri = URI.parse(location)
        session[hive_admin_stored_location_key] = [uri.path.sub(/\A\/+/, '/'), uri.query].compact.join('?')
      end
    end

    private
      def hive_admin_stored_location_key
        'hive_admin_return_to'
      end

  end
end
