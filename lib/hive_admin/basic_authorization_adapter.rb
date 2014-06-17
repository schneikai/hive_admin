# Basic authorization vor HiveAdmin. Just checks if a user has the *admin* role.

module HiveAdmin
  class BasicAuthorizationAdapter < ::ActiveAdmin::AuthorizationAdapter
    def authorized?(action, subject = nil)
      user.has_role? :admin
    end
  end
end
