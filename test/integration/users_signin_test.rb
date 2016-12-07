require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
  	@user = User.create(email: 'washington@example.com', 
  											password: Devise::Encryptor.digest(User, 'foobar'),
  											first_name: 'george',
  											last_name: 'washington')
  end

  test 'invalid user sign in' do
	  get new_user_session_path
	  assert_template 'sessions/new'
	  post new_user_session_path, session: { email: '',
	  																 	password: ''
	  																}
	  assert_template 'sessions/new'
	  assert_select '.alert'
	end

	test 'valid user sign in' do
		get new_user_session_path
		post user_session_path, 'user[email]' => @user.email,
														'user[password]' => @user.password
	 	assert_redirected_to @user
	 	follow_redirect!
	 	assert_template 'users/show'
	 	assert_select 'a[href=?]', destroy_user_session_path, count: 1
	end
end
