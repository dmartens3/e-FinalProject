require "test_helper"

class PaymentControllerTest < ActionDispatch::IntegrationTest
  test "should get proceed" do
    get payment_proceed_url
    assert_response :success
  end
end
