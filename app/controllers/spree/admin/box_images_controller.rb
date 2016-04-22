module Spree
  module Admin
    class BoxImagesController < ResourceController
       before_action :load_data

      create.before :set_viewable
      update.before :set_viewable

      def model_class
        Dish::BoxImage
      end

      def show
        redirect_to action: :edit
      end

      def new
        @box_image = @box.images.build
      end

      private 
        def location_after_destroy
        end

        def location_after_save
          edit_admin_box_box_image_url(@box,@box.images.first)
        end

        def load_data
          @box = Dish::Box.find(params[:box_id])
        end

        def set_viewable
          @box_image.viewable_type = 'Dish::Box'
          @box_image.viewable_id = params[:box_image][:viewable_id]
        end
    end
  end
end