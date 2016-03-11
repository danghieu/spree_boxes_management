class CreateBoxProducts < ActiveRecord::Migration
  def change
    create_table :box_products do |t|
      t.integer :product_id
      t.integer :box_id
      t.timestamps null: false
    end
    add_foreign_key :box_products, :spree_products, column: 'product_id'
    add_foreign_key :box_products, :boxes, column: 'box_id'
  end
end
