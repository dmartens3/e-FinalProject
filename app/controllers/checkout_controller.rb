class CheckoutController < ApplicationController
  def create
    # establish a connection with stripe and go to payment screen
  end

  def success
    # payment has been recieved
  end

  def cancel
    # the transaction was interrupted or cancelled
  end
end
