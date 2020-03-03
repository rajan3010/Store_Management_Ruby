class CreatePurchaselists < ActiveRecord::Migration[6.0]
  def change
    create_table :purchaselists do |t|
      t.integer :purchase_id
      t.integer :item_id
      t.boolean :ispending?, default: false
      t.timestamps
    end
  end
end
