# This migration comes from hive_engine (originally 20131031165723)
class DeviseAvatarableAddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
  end
end


