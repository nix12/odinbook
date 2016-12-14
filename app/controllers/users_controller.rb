class UsersController < ApplicationController
	def index
		@users = User.search(params[:search])
	end

	def show
		@user = User.find(params[:id])
		@post = @user.posts.build
		@posts = @user.posts.each
		@feed_items = @user.feed.page(params[:page]).per(10)
	end
end
