require "test_helper"

class OrderMenuItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get order_menu_items_create_url
    assert_response :success
  end

  test "should get update" do
    get order_menu_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get order_menu_items_destroy_url
    assert_response :success
  end
end
