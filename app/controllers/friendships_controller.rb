class FriendshipsController < ApplicationController
	def index
		@friendships = current_user.friendships.all
	end

	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
	
		if @friendship.save
			flash[:success] = 'Added friend'
			redirect_to user_path(current_user)
		else
			flash[:danger] = 'Failure to add friend'
			redirect_to user_path(current_user)
		end
	end

	def update
		# raise params[:id].inspect
    @friendship = Friendship.find(params[:user_id])
    @friendship.update(accepted: true)
    
    if @friendship.save
      redirect_to root_url, notice: "Successfully confirmed friend!"
    else
      redirect_to root_url, notice: "Sorry! Could not confirm friend!"
    end
  end

	def destroy
		@friendship = Friendship.select(:id).where('user_id = ? AND friend_id = ?', 
																								params[:friend_id].to_i, 
																								current_user.id).first
		# raise params[:friend_id].to_i.inspect
		@friendship.destroy
		flash[:notice] = 'Friend removed'
		redirect_to user_path(current_user)
	end
end
