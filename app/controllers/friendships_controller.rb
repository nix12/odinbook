class FriendshipsController < ApplicationController                   
	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
	
		if @friendship.save
			Notification.create(recipient_id: @friendship.friend_id, checked: false)

			flash[:success] = 'Added friend'
			redirect_to user_path(current_user)
		else
			flash[:danger] = 'Failure to add friend'
			redirect_to user_path(current_user)
		end
	end

	def update
    @friendship = Friendship.find(params[:id])
    # raise @friendship.inspect
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
		@friendship.destroy
		flash[:notice] = 'Friend removed'
		redirect_to user_path(current_user)
	end
end
