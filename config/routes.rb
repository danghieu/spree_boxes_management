Spree::Core::Engine.routes.draw do
  
  namespace :admin do
    resources :boxes do
      member do
        post 'active'
      end
      resources :box_images
    end
    concern :box_products_concern do
      resources :box_products
    end

    resources :products, concerns: :box_products_concern
    resources :boxes, concerns: :box_products_concern
    # Add your extension routes here
  end


  namespace :api do
    post "products_search_by_dish_type_and_name" => "products#search_by_dish_type_and_name"
    post "box_product_create" => "box_products#update"
    get  "boxes_serve_date" => "box_products#serve_date"
  end
    
end
