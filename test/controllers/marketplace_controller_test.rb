require 'test_helper'

class MarketplaceControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get marketplace_get_url
    assert_response :success
  end

end
