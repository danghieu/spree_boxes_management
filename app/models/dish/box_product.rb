module Dish
  class BoxProduct < ActiveRecord::Base
    belongs_to :product, :class_name => "Spree::Product",foreign_key: "product_id"
    belongs_to :box,  :class_name => "Dish::Box",foreign_key: "box_id"
  end
end