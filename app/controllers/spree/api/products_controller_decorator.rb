Spree::Api::ProductsController.class_eval do
  def search_by_dish_type_and_name
    if params[:q].present?     
      ps = Spree::Product.ransack(name_cont: params[:q]).result
      @products=ps.where(dish_type_id: params[:dish_type])
      render "spree/api/available_ons/serve_date", status: 200
  	else
  		render "spree/api/available_ons/serve_date", status: 204
    end
  end
end