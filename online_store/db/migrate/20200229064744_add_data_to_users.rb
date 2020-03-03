class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer, default: 19
    add_column :users, :card_name, :string
    add_column :users, :card_no, :integer
    add_column :users, :card_exp, :string
    add_column :users, :cvv, :integer
  end
end
