class CommentsController < ApplicationController
	def index
		@post = Post.find(params[:post_id])
		@comments = Comment.where('post_id = ?', @post).order(created_at: :desc).page(params[:page]).per(10)
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.build(comment_params)


		if @comment.save
			flash[:success] = 'Comment successful'
			redirect_to post_comments_path
		else
			flash[:error] = 'Comment failed'
			redirect_to post_comments_path
		end
	end

	def destroy
		
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
