# This migration comes from hive_engine (originally 20131007180918)
class CreateDeviseAuthorizableRoles < ActiveRecord::Migration
  def change
    create_table(:devise_authorizable_roles) do |t|
      t.integer :authorizable_id
      t.string :authorizable_type
      t.string :name

      t.timestamps
    end

    add_index :devise_authorizable_roles, [:authorizable_id, :authorizable_type], name: 'devise_authorizable_roles_index'
  end
end
