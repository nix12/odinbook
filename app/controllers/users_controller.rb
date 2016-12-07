class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@post = @user.posts.build
		@posts = @user.posts.each
		@feed_items = @user.feed.page(params[:page]).per(20)
	end
end
