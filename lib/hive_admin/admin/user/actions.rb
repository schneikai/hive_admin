ActiveAdmin.register User do
  member_action :confirm, method: :put do
    resource.confirm! unless resource.confirmed?

    redirect_location = URI(request.referer).path || resource_path
    redirect_to redirect_location, notice: "User has been confirmed successfully!"
  end

  action_item only: :show do
    if authorized?(:confirm, resource) && resource.confirmable? && !resource.confirmed?
      link_to('Confirm', confirm_admin_user_path(resource), method: :put)
    end
  end

  member_action :impersonate, method: :get do
    impersonate_user(resource)
    redirect_to root_path
  end

  collection_action :stop_impersonating, method: :get do
    stop_impersonating_user
    redirect_to admin_users_path
  end
end
