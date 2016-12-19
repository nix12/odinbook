require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	def setup
		@user = users(:thomas)
	end

	test 'get user profile page' do
		sign_in @user
		get :show, { id: @user.id }
		assert_response :success
	end
end
