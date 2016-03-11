module Spree
  module Admin
    class BoxesController < ResourceController
      before_action :load_data, except: :index
      #create.after :add_dishes_to_box
      def model_class
        Dish::Box
      end
      
      def show
        redirect_to action: :edit
      end

      def create
        @box = Dish::Box.new(box_params)
        @dish_types = Dish::DishType.all
        @dish_types.each do |dish_type|
          @box.products<<[Spree::Product.where(dish_type_id: dish_type.id).first]
        end
        @box.save
        redirect_to  admin_boxes_url
      end

      def load_data
      end

      def location_after_save
        admin_boxes_url
      end

      def active
        @box = Dish::Box.find(params[:id])
        if @box.is_active
          @box.is_active =false
        else
          @box.is_active =true
        end
        @box.save
        redirect_to  admin_boxes_url
      end
      private
      def box_params
        params.require(:box).permit(:name, :descriptions)
      end

      private
      def add_dishes_to_box
        p "2222222222222222222222222222222222222222222222222222222222222222222222222"
        @box = Dish::Box.new(box_params)
        @dish_types = Dish::DishType.all
        @dish_types.each do |dish_type|
          @box.products<<[Spree::Product.where(dish_type_id: @dish_type.id).first]
        end
        @box.save
        redirect_to  admin_boxes_url

      end

      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= "1"

        params[:q][:s] ||= "name asc"
        @collection = super
        if params[:q].delete(:deleted_at_null) == '0'
          @collection = @collection.with_deleted
        end
        # @search needs to be defined as this is passed to search_form_for
        @search = @collection.ransack(params[:q])
        @collection = @search.result.
              page(params[:page]).
              per(params[:per_page] || Spree::Config[:admin_products_per_page])

        @collection
      end 

    end
  end
end