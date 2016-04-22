module Spree
  module Admin
    class BoxProductsController < ResourceController
      before_action :load_data

      def model_class
        Dish::BoxProduct
      end

      def edit
        
      end

      def index 
        unless @box.is_active
           render action: 'edit'
        end 
      end

      def show
        redirect_to action: :edit
      end


      def load_data
        @box = Dish::Box.find(params[:box_id])
        @dish_types=Dish::DishType.all
      end

      def location_after_save
        admin_boxes_url
      end

    end
  end
end
