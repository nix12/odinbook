class PostsController < ApplicationController
	def index

		
		@posts = Post.where(user_id: wall_ids).order(created_at: :desc).page(params[:page]).per(20)
		@post = Post.new
	end

	def create
		@user = current_user
		@feed_items = current_user.feed.page(params[:page]).per(10)
		@post = current_user.posts.build(post_params)

		if @post.save
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

		def wall_ids
			ids = current_user.friends.map do |friend|
				p friend.id
			end
			ids << current_user.id

			return ids
		end
end
