ActiveAdmin.register User do
  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :email
      f.input :username
      f.input :password, as: :string, hint: 'Enter a new password to change the current password or leave blank to keep the current password.'
    end

    # TODO: This should be read from Hive configuration...
    # TODO: In Photocase we use ISO codes for country and state. It looks like
    # formatstics country select has just the country names... Do we leave this up
    # to the host app or do we add something to Hive that allows ISO Code select
    # from a dropdown for country and state?
    f.inputs do
      f.input :company
      f.input :first_name
      f.input :last_name
      f.input :address1
      f.input :address2
      f.input :zip
      f.input :city
      f.input :country, as: :string
      f.input :state
    end

    f.inputs do
      f.input :remove_avatar, as: :boolean, label: 'Delete current avatar'
    end

    # TODO: Would be more nice to have like a tag input for this...
    # http://hoff2.com/2013/11/09/acts_as_taggable_on_active_admin_select2.html
    # or
    # http://staal.io/blog/2013/02/26/mastering-activeadmin/
    # https://github.com/inossidabile/mastering_aa/blob/master/config/initializers/active_admin/filter_multiple_select_input.rb
    if authorized?(:rolify, user)
      f.has_many :rolez, allow_destroy: true do |p|
        p.input :name
      end
    end

    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :email, :username, :password, :company, :first_name, :last_name, :address1, :address2, :zip, :city, :country, :state, :remove_avatar, rolez_attributes: [:id, :name, :_destroy]
end
