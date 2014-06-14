ActiveAdmin.register User do
  # No need to confirm accounts when created here.
  after_build do |user|
    user.skip_confirmation! if user.confirmable?
  end

  controller do
    def update
      # Remove blank password to just keep the current password in that case.
      params[:user].delete(:password) if params[:user][:password].blank?

      # If a new password was set copy it to the *password_confirmation* field
      # to pass the password confirmation validation.
      if params[:user][:password].present?
        params[:user][:password_confirmation] = params[:user][:password]
      end

      super
    end
  end
end
