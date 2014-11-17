ActiveAdmin.register User do
  member_action :confirm, method: :put do
    authorize! :confirm, resource

    resource.confirm! unless resource.confirmed?

    redirect_to hive_admin_return_path(resource_path(resource)), notice: "User confirmed successfully!"
  end

  action_item only: :show do
    if authorized?(:confirm, resource) && resource.confirmable? && !resource.confirmed?
      link_to('Confirm', confirm_admin_user_path(resource), method: :put)
    end
  end


  member_action :impersonate, method: :get do
    authorize! :impersonate, resource

    impersonate_user(resource)
    redirect_to root_path
  end

  action_item only: :show do
    if authorized?(:impersonate, resource)
      link_to('Confirm', confirm_admin_user_path(resource), method: :put)
    end
  end


  collection_action :stop_impersonating, method: :get do
    stop_impersonating_user
    redirect_to admin_users_path
  end
end
