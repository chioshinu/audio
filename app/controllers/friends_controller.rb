class FriendsController < ApplicationController
  def view
    @user = current_user
  end

  def add
    @friendship = current_user.pending_friendships.build(:friend_id => params[:id], :confirmed => false)
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

end
