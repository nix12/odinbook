require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
  	@post = posts(:one)
  end

  test 'must be valid' do
  	assert @post.valid?
  end

  test 'post must be present' do
  	@post.content = ' '
  	assert_not @post.valid?
  end

  test 'post can be maximum 5000 characters' do
  	@post.content = 'a' * 5001
  	assert_not @post.valid?
  end

  test 'post user id must be present' do
  	@post.user_id = nil
  	assert_not @post.valid?
  end
end
