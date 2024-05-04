require 'test_helper'

class Api::MovieControllerTest < ActionController::TestCase
    test "Should get index" do
        get :index
        assert_response :success

        expected_json = { message: 'Olá, mundo!' }.to_json
        assert_equal expected_json, @response.body
    end
end