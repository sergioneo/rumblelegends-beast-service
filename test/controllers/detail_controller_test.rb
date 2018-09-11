require 'test_helper'

class DetailControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get detail_get_url
    assert_response :success
  end

end
