require "test_helper"

class CarriersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get carriers_new_url
    assert_response :success
  end

  test "should get create" do
    get carriers_create_url
    assert_response :success
  end

  test "should get index" do
    get carriers_index_url
    assert_response :success
  end
end
