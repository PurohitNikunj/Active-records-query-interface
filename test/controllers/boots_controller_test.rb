require "test_helper"

class BootsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boots_index_url
    assert_response :success
  end
end
