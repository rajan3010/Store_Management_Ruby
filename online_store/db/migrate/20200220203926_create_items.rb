class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :brand
      t.string :name
      t.string :category
      t.boolean :is_restricted?
      t.boolean :is_age_restricted?
      t.integer :quantity
      t.decimal :cost
      t.string :tax_slab
      t.integer :purchase_count
      t.integer :user_id

      t.timestamps
    end
  end
end
