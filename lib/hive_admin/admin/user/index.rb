ActiveAdmin.register User do
  filter :id_equals, as: :string, label: "ID"
  filter :username_or_email_or_company_or_first_name_or_last_name, as: :string, label: "Username, Email or Userdata"

  # TODO: Active admin allows to define multiple index pages for tha same resource
  # so when users would create a new index in their app this would actually
  # not overwriting the index from here instead it would create another index page.
  # By setting *default: true* in the host apps index one can make this index the
  # default index. Found no way of simply overwrting a already defined index.
  # The code for this index stuff is in the ActiveAdmin Gem
  # ActiveAdmin::Resource::PagePresenters#set_index_presenter
  # https://github.com/gregbell/active_admin/blob/master/docs/3-index-pages.md
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

    actions defaults: true, dropdown: true do |user|
      if controller.action_methods.include?('impersonate') && authorized?(:impersonate, user)
        item 'Login', impersonate_admin_user_path(user), class: 'impersonate_link'
      end

      if controller.action_methods.include?('confirm') && authorized?(:confirm, user) && user.confirmable? && !user.confirmed?
        item 'Confirm', confirm_admin_user_path(user), method: :put, class: 'confirm_link'
      end
    end
  end
end
