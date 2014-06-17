# Overwrite ActiveAdmin::CanCanAdapter methods to prefix the action with
# ActiveAdmins current namespace. This was done so we can distinguish between
# regular front end actions and actions from the admin area when defining abilities.
#
#   can [:create, :read, :update, :destroy], User
#   can [:admin_create, :admin_read, :admin_update, :admin_destroy], User
#
# Check README under "Security" for more information.

module HiveAdmin
  class CanCanAuthorizationAdapter < ::ActiveAdmin::CanCanAdapter
    def authorized?(action, subject = nil)
      cancan_ability.can?([resource.namespace.name, action].join('_').to_sym, subject)
    end

    def scope_collection(collection, action = ActiveAdmin::Auth::READ)
      collection.accessible_by(cancan_ability, [resource.namespace.name, action].join('_').to_sym)
    end
  end
end
