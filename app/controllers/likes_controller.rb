class LikesController < ApplicationController
	def create
		@likes = current_user.likes.build
		@likes.post_id = params[:post_id]

		if @likes.save
			flash[:success] = 'Liked post'
			redirect_to posts_path
		else
			redirect_to posts_path
		end
	end
end
