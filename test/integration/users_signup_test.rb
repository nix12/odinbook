require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	
	test 'invalid sign up' do
		get new_user_registration_path
		assert_template 'registrations/new'
		assert_no_difference 'User.count' do
			post user_registration_path user: { first_name: '',
																					last_name: '',
																					email: 'invalid@asdf$com',
																					password: 'foo',
																					password_confirmation: 'bar'
																				}
  	end
  	assert_template 'registrations/new'
  	assert_select 'div#error_explanation'
  end

  test 'valid user sign up' do
  	get new_user_registration_path
  	assert_template 'registrations/new'
  	assert_difference 'User.count', 1 do
  		post user_registration_path user: { first_name: 'john',
  																				last_name: 'adams',
  																				email: 'adams@example.com',
  																				password: 'foobar',
  																				password_confirmation: 'foobar'
  																			}
  	end

  	user = assigns(:user)
  	sign_in user
  	follow_redirect!
  	assert_template 'users/show'
  end
end
