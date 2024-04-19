class CartController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]

  def add_to_cart
    session[:cart] ||= []
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    quantity.times { session[:cart] << product_id }

    redirect_to cart_path, notice: 'Product added to cart!'
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

  def invoice
    session[:cart] ||= []
    cart_item_ids = session[:cart]
    @cart_items = {}
    @user = current_user
    province_id = @user.province_id
    @user_province = Province.find(province_id)

    if cart_item_ids.length == 0
      redirect_to cart_path, alert: "You cannot checkout with an empty cart!"
    end

    cart_item_ids.each do |product_id|
      if @cart_items[product_id]
        @cart_items[product_id][:quantity] += 1
      else
        product = Product.find(product_id)
        @cart_items[product_id] = { product: product, quantity: 1 }
      end
    end

    @base_total = 0
    @cart_items.each do |product_id, cart_item|
      @base_total += cart_item[:product].price * cart_item[:quantity]
    end
    
    @total = @base_total + (@base_total * @user_province.pst) + (@base_total * @user_province.gst) + (@base_total * @user_province.hst)

  end# invoice

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
