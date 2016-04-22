module Dish
  class BoxProduct < ActiveRecord::Base
    belongs_to :product, :class_name => "Spree::Product",foreign_key: "product_id"
    belongs_to :box,  :class_name => "Dish::Box",foreign_key: "box_id"

    def self.add_dish_to_box
      max_d = Dish::BoxProduct.maximum(:delivery_date)
      daily_box_id = Dish::Box.where(is_active: true).first.id
      weekly_box_id = Dish::Box.where(is_active: false).first.id
      monday = Date.today.beginning_of_week
      nextWeek= monday+7
      if max_d.nil?
        21.times.each do |i|
          delivery_date = monday-7+i
          add_product_in_next_week(daily_box_id,delivery_date)
        end
        add_product_in_next_week(weekly_box_id,monday)
        add_product_in_next_week(weekly_box_id,nextWeek)
      else
        if nextWeek > max_d
          7.times.each do |i|
            delivery_date = nextWeek+i
            add_product_in_next_week(daily_box_id,delivery_date)
          end
          add_product_in_next_week(weekly_box_id,nextWeek)
        end
      end
    end #end def daily_box

    private
    def self.add_product_in_next_week(box_id,delivery_date)
      products=[]
      product_ids = Dish::AvailableOn.where(:delivery_date => delivery_date).pluck(:product_id)
      ps = Spree::Product.where(:id => product_ids)
      Dish::DishType.all.each do |dish_type|
        products<<ps.where(dish_type_id: dish_type.id).first
      end
      products.each do |p|
        bp = Dish::BoxProduct.create(box_id: box_id,product_id: p.id,delivery_date: delivery_date)
      end
    end #def add_product_in_next_week
  end
end
