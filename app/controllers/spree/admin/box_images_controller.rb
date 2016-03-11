module Spree
  module Admin
    class BoxImagesController < ResourceController
       before_action :load_data

      create.before :set_viewable
      update.before :set_viewable

      def model_class
        Dish::BoxImage
      end

      def edit
      end

      def new
        @box_image = @box.images.build
      end

      private 
        def location_after_destroy
        end

        def location_after_save
          admin_box_box_images_url(@box)
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