class PostsController < ApplicationController
	def index
		@posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(20)
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = 'Post successful'
			redirect_to user_path(current_user)
		else
			flash[:error] = 'Post unsuccessful'
			redirect_to user_path(current_user)
		end
	end

	def destroy
		
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end
end
