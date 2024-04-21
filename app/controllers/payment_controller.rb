class PaymentController < ApplicationController
  def proceed
    redirect_to checkout_create_path
  end
end
