class PostsController < ApplicationController
	def index
		# ids = User.pluck(:id).where('id IN ?', current_user.friends)
		ids = current_user.friends.map do |friend|
			p friend.id
		end
		ids << current_user.id
		# raise ids.inspect
		@posts = Post.where(user_id: ids).order(created_at: :desc).page(params[:page]).per(20)
		# @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(20)
		@post = Post.new
	end

	def create
		@user = current_user
		@feed_items = current_user.feed.page(params[:page]).per(10)
		@post = current_user.posts.build(post_params)

		if @post.save
			flash.now[:success] = 'Post successful'
			redirect_to user_path(current_user)
		else
			flash.now[:error] = 'Post unsuccessful'
			render 'users/show'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.present?
			@post.destroy
		end
		flash[:success] = 'Post deleted.'
		redirect_to user_path(current_user)
	end

	private

		def post_params
			params.require(:post).permit(:content, :image)
		end
end
