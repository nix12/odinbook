require 'test_helper'

class CommentInterfaceTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
  	@user = users(:thomas)
  	@post = posts(:one)
  	@comment = comments(:first_comment)
  end

  test 'comments interface' do
  	sign_in @user
  	get post_comments_path(@post)

  	assert_no_difference 'Comment.count' do 
  		post post_comments_path comment: { content: '' }
  	end
  	assert_select 'div.error_explanation'
  
  	assert_difference 'Comment.count', 1 do
  		post post_comments_path comment: { content: @comment.content }
  	end
  	assert_redirected_to post_comments_path(@post)
  	follow_redirect!
  	assert_match @comment.content, response.body

  	assert_select 'a', text: 'Delete'

  	first_comment = @post.comments.first
  	assert_difference 'Comment.count', -1 do
  		delete post_comment_path(@post, first_comment)
  	end

  	get post_comments_path(@post)
  	assert_select 'a', text: 'Delete', count: 0
  end
end
