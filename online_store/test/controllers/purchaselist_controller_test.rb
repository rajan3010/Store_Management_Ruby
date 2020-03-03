require 'test_helper'

class PurchaselistControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchaselist_index_url
    assert_response :success
  end

  test "should get show" do
    get purchaselist_show_url
    assert_response :success
  end

end
