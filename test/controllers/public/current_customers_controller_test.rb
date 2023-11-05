require "test_helper"

class Public::CurrentCustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_current_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_current_customers_edit_url
    assert_response :success
  end
end
