module Dish
  class Box < ActiveRecord::Base
    validates_presence_of :name

    has_many :products , through: :box_products, :class_name => "Spree::Product"
    has_many :box_products, dependent: :destroy , :class_name => "Dish::BoxProduct"
    has_many :images, as: :viewable, dependent: :destroy, class_name: "Dish::BoxImage"
    has_many :comments, :class_name => "Dish::Comment"

    accepts_nested_attributes_for :box_products,
      :reject_if => :all_blank,
      :allow_destroy => true
    accepts_nested_attributes_for :products
    accepts_nested_attributes_for :comments

    def self.add_weekly_box
        box = Dish::Box.create(name: "Weekly Box",is_active: false)
        dish_types = Dish::DishType.all
        dish_types.each do |dish_type|
          box.products<<[Spree::Product.where(dish_type_id: dish_type.id).first]
        end
        box.save
    end
  end
end
