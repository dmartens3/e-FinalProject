class CheckoutController < ApplicationController
  def create
    # establish a connection with stripe and go to payment screen
    session[:cart] ||= []
    cart_item_ids = session[:cart]
    @cart_items = {}
    @user = current_user
    @user_province = Province.find(@user.province_id)

    if cart_item_ids.length == 0
      redirect_to cart_path, alert: "You cannot checkout with an empty cart!"
    end

    cart_item_ids.each do |product_id|
      if @cart_items[product_id]
        @cart_items[product_id][:quantity] += 1
      else
        @cart_items[product_id] = { quantity: 1 }
      end
    end
    
    line_items = []
    total_pst = 0
    total_gst = 0
    total_hst = 0

    @cart_items.each do |product_id, cart_item|
      quantity = cart_item[:quantity]
      product = Product.find(product_id)
      unit_amount = (product.price * 100.0).to_i
      total_amount = (unit_amount * quantity)

      total_pst += (total_amount * @user_province.pst).to_i
      total_gst += (total_amount * @user_province.gst).to_i
      total_hst += (total_amount * @user_province.hst).to_i

      line_items << {
        quantity: quantity,
        price_data: {
          unit_amount: unit_amount,
          currency: "cad",
          product_data: {
            name: product.name
          }
        }# price_data: {
      }# line_items << {
    end# @cart_item.each do |item|

    if total_pst != 0
      line_items << {
        quantity: 1,
        price_data: {
          unit_amount: total_pst,
          currency: "cad",
          product_data: {
            name: "PST"
          }
        }# price_data: {
      }# line_items << {
    end# if total_pst != 0

    if total_gst != 0
      line_items << {
        quantity: 1,
        price_data: {
          unit_amount: total_gst,
          currency: "cad",
          product_data: {
            name: "GST"
          }
        }# price_data: {
      }# line_items << {
    end# if total_gst != 0

    if total_hst != 0
      line_items << {
        quantity: 1,
        price_data: {
          unit_amount: total_hst,
          currency: "cad",
          product_data: {
            name: "HST"
          }
        }# price_data: {
      }# line_items << {
    end# if total_hst != 0

    
    @session = Stripe::Checkout::Session.create(
      customer_email: @user.email,
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: line_items
    )# @session = Stripe::Checkout::Session.create(
    
    redirect_to @session.url, allow_other_host: true

  end# create

  def success
    # payment has been recieved
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @session_id = params[:session_id]
    @payment_status = @session[:payment_status]

    @base_total = 0
    @total = 0
    session[:cart] ||= []
    cart_item_ids = session[:cart]
    @cart_items = {}
    @user = current_user
    @user_province = Province.find(@user.province_id)

    cart_item_ids.each do |product_id|
      if @cart_items[product_id]
        @cart_items[product_id][:quantity] += 1
      else
        product = Product.find(product_id)
        @cart_items[product_id] = { product: product, quantity: 1 }
      end
    end

    order = Order.create(status_id: 1, user_id: @user.id, stripe_payment_id: @session_id, total: 0.0)

    @cart_items.each do |product_id, cart_item|
      quantity = cart_item[:quantity]
      product = Product.find(product_id)
      unit_amount = (product.price * 100.0).to_i
      total_amount = (unit_amount * quantity)
      cost = total_amount / 100.0
      @base_total += cost
      tax_paid = (total_amount * @user_province.pst).to_i
      tax_paid += (total_amount * @user_province.gst).to_i
      tax_paid += (total_amount * @user_province.hst).to_i
      decimal_tax_paid = tax_paid / 100.0
      @total = @total + cost + decimal_tax_paid

      sale = Sale.create(quantity: quantity, cost: cost, tax: decimal_tax_paid, product_id: product_id, order_id: order.id)
    end# @cart_items.each do |product_id, cart_item|

    if @payment_status == 'paid'
      order.update(status_id: 2, total: @total)
      order.save
    end
    
    session[:cart] = []

  end

  def cancel
    # the transaction was interrupted or cancelled
    redirect_to see_invoice_path, alert: "Payment not completed."
  end
end
