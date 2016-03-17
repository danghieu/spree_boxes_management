module Dish
  class BoxProduct < ActiveRecord::Base
    belongs_to :product, :class_name => "Spree::Product",foreign_key: "product_id"
    belongs_to :box,  :class_name => "Dish::Box",foreign_key: "box_id"

    def self.add_dish_to_daily_box
      max_d = Dish::BoxProduct.maximum(:delivery_date)
      box_id = Dish::Box.first.id
      monday = Date.today.beginning_of_week
      nextWeek= monday+7
      if max_d.nil?
        21.times.each do |i|
          serve_date = monday-7+i
          products=[]
          product_ids = Dish::AvailableOn.where(:delivery_date => serve_date).pluck(:product_id)
          puts product_ids.inspect
          ps = Spree::Product.where(:id => product_ids)
          Dish::DishType.all.each do |dish_type|
            products<<ps.where(dish_type_id: dish_type.id).first
          end
          puts products.inspect
          products.each do |p|

            bp = Dish::BoxProduct.new 
            bp.delivery_date = serve_date
            bp.product_id = p.id
            bp.box_id = box_id
            bp.save
          end
        end
      else
      	
        if nextWeek > max_d
          7.times.each do |i|
            serve_date = nextWeek+7+i
            products=[]
            product_ids = Dish::AvailableOn.where(:delivery_date => serve_date).pluck(:product_id)
            ps = Spree::Product.where(:id => product_ids)
            Dish::DishType.all.each do |dish_type|
            	products<<ps.where(dish_type_id: dish_type.id).first
          	end
          	products.each do |p|
          		bp = Dish::BoxProduct.new 
          		bp.delivery_date = serve_date
          		bp.product_id = p.id
          		bp.box_id = box_id
          		bp.save
          	end
          end
        end
      end

    end
  end
end
