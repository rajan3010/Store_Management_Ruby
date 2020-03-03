class AddRolesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isadmin?, :boolean, default:false
    add_column :users, :isguest?, :boolean, default:false
  end
end
