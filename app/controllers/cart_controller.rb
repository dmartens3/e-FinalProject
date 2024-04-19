class CartController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]

  def add_to_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    
    session[:cart] ||= []
    quantity.times { session[:cart] << product_id }
    redirect_to root_path, notice: 'Product added to cart!'
  end

  def show
    cart_item_ids = session[:cart]
    @cart_items = {}

    cart_item_ids.each do |product_id|
      product = Product.find(product_id)
      if @cart_items[product.id]
        @cart_items[product.id][:quantity] += 1
      else
        @cart_items[product.id] = { product: product, quantity: 1 }
      end
    end
  end
end
