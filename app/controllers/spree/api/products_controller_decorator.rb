Spree::Api::ProductsController.class_eval do
  def search_by_dish_type_and_name
    if params[:q].present?
      @products = Spree::Product.ransack(name_cont: params[:q]).result
      unless params[:serve_date].blank?
      	date = Date.parse(params[:serve_date])     
      	product_ids = Dish::AvailableOn.where(:delivery_date => date).pluck(:product_id)
      	@products=@products.where(id: product_ids)
      end
      @products=@products.where(dish_type_id: params[:dish_type])
      render "spree/api/available_ons/serve_date", status: 200
  	else
  		render "spree/api/available_ons/serve_date", status: 204
    end
  end
end