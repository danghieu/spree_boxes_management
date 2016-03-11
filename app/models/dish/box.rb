module Dish
  class Box < ActiveRecord::Base
    validates_presence_of :name

    has_many :products , through: :box_products, :class_name => "Spree::Product"
    has_many :box_products, dependent: :destroy , :class_name => "Dish::BoxProduct"
	has_many :images, as: :viewable, dependent: :destroy, class_name: "Dish::BoxImage"
    accepts_nested_attributes_for :box_products,
      :reject_if => :all_blank,
      :allow_destroy => true
    accepts_nested_attributes_for :products

  end
end
