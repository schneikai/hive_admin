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
  end
end
