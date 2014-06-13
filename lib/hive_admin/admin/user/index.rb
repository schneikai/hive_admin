ActiveAdmin.register User do
  filter :id
  filter :username
  filter :email
  filter :company
  filter :first_name
  filter :last_name

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :name do |user|
      [user.company.presence, user.first_name.presence, user.last_name.presence].compact.join(' ')
    end
    column 'registered', :created_at

    column :roles do |user|
      (user.roles - [:authenticated]).join(', ')
    end

    column :status do |user|
      if user.try(:locked?).is_a?(TrueClass)
        status_tag('locked', :red)
      elsif user.confirmable? && !user.confirmed?
        status_tag('unconfirmed')
      end
    end

    actions defaults: true do |user|
      # We need to concanate all links or it will just show the last link.
      links = ''.html_safe
      links += link_to('Login', impersonate_admin_user_path(user), class: 'member_link impersonate_link')
      links += link_to('Confirm', confirm_user_admin_user_path(user), method: :put, class: 'member_link confirm_link') if user.confirmable? && !user.confirmed?
      links
    end
  end
end
