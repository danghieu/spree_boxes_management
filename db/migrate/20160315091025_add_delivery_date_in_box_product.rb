class AddDeliveryDateInBoxProduct < ActiveRecord::Migration
  def change
  	add_column :box_products,  :delivery_date, :date
  end
end
