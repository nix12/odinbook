class PostsController < ApplicationController
	def index
		@posts = current_user.posts
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			flash[:success] = 'Post successful'
			redirect_to posts_path
		else
			flash[:danger] = 'Post unsuccessful'
			render 'users/show'
		end
	end

	def destroy
		
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end
end
