class CartController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]

  def add_to_cart
    session[:cart] ||= []
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    quantity.times { session[:cart] << product_id }

    redirect_to root_path, notice: 'Product added to cart!'
  end# add_to_cart

  def show
    session[:cart] ||= []
    cart_item_ids = session[:cart]
    @cart_items = {}

    cart_item_ids.each do |product_id|
      if @cart_items[product_id]
        @cart_items[product_id][:quantity] += 1
      else
        product = Product.find(product_id)
        @cart_items[product_id] = { product: product, quantity: 1 }
      end
    end
  end# show

  def update_quantity
    session[:cart] ||= []
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    
    while session[:cart].include?(product_id)
      session[:cart].delete(product_id)
    end
    
    quantity.times { session[:cart] << product_id }

    redirect_to cart_path, notice: "Successfully changed the quantity to #{quantity}."
  end# update_quantity

  def remove_from_cart
    session[:cart] ||= []
    product_id = params[:product_id].to_i

    while session[:cart].include?(product_id)
      session[:cart].delete(product_id)
    end

    redirect_to cart_path, notice: "Successfully removed the item from cart."
  end# remove_from_cart

end
