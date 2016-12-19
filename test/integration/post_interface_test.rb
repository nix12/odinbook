require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers

  def setup
  	@user = users(:thomas)
  	@post = posts(:one)
  end

  test 'post interface' do
  	sign_in @user
  	get user_path(@user)
  	
  	assert_no_difference 'Post.count' do
  		post posts_path post: { content: ' ' }
  	end
  	assert_select 'div.error_explanation'

  	assert_difference 'Post.count', 1 do
  		post posts_path post: { content: @post.content }
  	end
  	assert_redirected_to user_path(@user)
  	follow_redirect!
  	assert_match @post.content, response.body

   	assert_select 'a', text: 'Delete'

   	first_post = @user.posts.first
  	assert_difference 'Post.count', -1 do
			delete post_path(first_post)
		end

		get user_path(@user)
		assert_select 'a', text: 'Delete', count: 0
  end
end
