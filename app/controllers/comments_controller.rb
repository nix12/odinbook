class CommentsController < ApplicationController
	def index
		@post = Post.find(params[:post_id])
		@comments = Comment.where('post_id = ?', @post).page(params[:page]).per(10)
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.build(comment_params)
		@comments = Comment.where('post_id = ?', @post).order(created_at: :desc).page(params[:page]).per(10)
		@post = Post.find(params[:post_id])
		@comment.post_id = @post.id
		
		if @comment.save
			redirect_to post_comments_path
		else
			flash[:error] = 'Comment failed'
			render :index
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = 'Comment deleted.'
		redirect_to post_comments_path(@post)
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
