module Spree
  module Api
    class BoxProductsController < Spree::Api::BaseController
      def update
        @b_p = Dish::BoxProduct.where(box_id: params[:box_id],product_id: params[:product_id_old],delivery_date: params[:serve_date]).first
        @b_p.product_id = params[:product_id_new]
        if @b_p.save!
          @products = Spree::Product.find(params[:product_id_new])
          render "spree/api/available_ons/serve_date", status: 200
        else
          @status = [{ "messages" => "something is wrong"}]
          render "spree/api/logger/log", status: 400
        end
      end

      def serve_date
        if params[:serve_date] 
          date = Date.parse(params[:serve_date])
          product_ids = Dish::BoxProduct.where(:delivery_date => date,:box_id => params[:box_id]).pluck(:product_id)
          @products = Spree::Product.where(:id => product_ids).order(:dish_type_id)
          render "spree/api/available_ons/serve_date", status: 200
        end
      end
    end
  end
end
