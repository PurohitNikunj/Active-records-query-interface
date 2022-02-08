require "test_helper"

class StudentValidationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_validations_index_url
    assert_response :success
  end

  test "should get new" do
    get student_validations_new_url
    assert_response :success
  end

  test "should get show" do
    get student_validations_show_url
    assert_response :success
  end

  test "should get edit" do
    get student_validations_edit_url
    assert_response :success
  end
end
