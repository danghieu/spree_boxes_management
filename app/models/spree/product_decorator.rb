Spree::Product.class_eval do 
	has_many :boxes , through: :box_products, :class_name => "Dish::Box"
    has_many :box_products, dependent: :destroy, :class_name => "Dish::BoxProducts"
    accepts_nested_attributes_for :box_products,
             :reject_if => :all_blank,
             :allow_destroy => true
    accepts_nested_attributes_for :boxes
end