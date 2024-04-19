require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  test "should get add_to_cart" do
    get cart_add_to_cart_url
    assert_response :success
  end

  test "should get show" do
    get cart_show_url
    assert_response :success
  end
end
