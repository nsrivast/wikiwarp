require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get add_game" do
    get :add_game
    assert_response :success
  end

end
