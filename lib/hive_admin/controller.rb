# Extensions for the host apps ApplicationController.
# Allows admins to login (aka impersonate) as a different user. This basically
# works by saving the id of the user to impersonate in the session and making
# the *current_user* method return this user instead of the actual user and adding
# a *true_user* method to return the actual user.
# The code was inspired by https://github.com/ankane/pretender.

module HiveAdmin
  module Controller
    extend ActiveSupport::Concern

    included do
      alias_method_chain :current_user, :impersonator
      helper_method :true_user
    end

    def true_user
      current_user_without_impersonator
    end

    def current_user_with_impersonator
      unless @impersonated_user
        # Only fetch impersonation if user is logged in and impersonation_id exists!
        if session[:impersonated_user_id] and !true_user
          session.delete(:impersonated_user_id)
        end
        user = (session[:impersonated_user_id] && User.where(id: session[:impersonated_user_id]).first) || true_user
        @impersonated_user = user
      end
      @impersonated_user
    end

    def impersonate_user(user)
      @impersonated_user = user
      session[:impersonated_user_id] = user.id
    end

    def stop_impersonating_user
      @impersonated_user = nil
      session.delete(:impersonated_user_id)
    end


    # Authentificates the current user for the ActiveAdmin. This basically
    # is every authenticated user that has the admin role.
    def authenticate_admin_user!
      authenticate_user!
      unless true_user.has_role? :admin
        flash[:alert] = "This area is restricted to administrators only."
        redirect_to root_path
      end
    end

    # Returns the current user for ActiveAdmin. We make sure no user is returned
    # if the current user does not have the admin role.
    def current_admin_user
      return nil if user_signed_in? && !true_user.has_role?(:admin)
      true_user
    end

  end
end
