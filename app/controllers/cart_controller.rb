class CartController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]
  
  def add_to_cart
  end

  def show
  end
end
