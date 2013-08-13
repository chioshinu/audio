class FriendsController < ApplicationController
  def view
    @user = current_user
  end

  def add
    if Friendship.all(:conditions => ["(user_id = ? and friend_id = ?) or (user_id = ? and friend_id = ?)", params[:id], current_user.id, current_user.id, params[:id]]).length == 0
      @friendship = current_user.pending_friendships.build(:friend_id => params[:id], :confirmed => false)

      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to root_url
      else
        flash[:error] = "Unable to add friend."
        redirect_to root_url
      end
    else
      flash[:error] = "Sorry, but you already add this user to friend"
      redirect_to root_url
    end
  end

  def accept
    @friendship = current_user.pending_friendships.find(params[:id])
    if @friendship
      @friendship.confirmed = true
      @friendship.save
      @inverse_friendsip = current_user.inverse_friendships.create(:user_id => @friendship.friend.id, :confirmed => true)
      @inverse_friendsip.save
      flash[:notice] = "Friendship request accepted"
      redirect_to manage_friends_path
    else
      flash[:error] = "Unable to accept Friendship request"
      redirect_to manage_friends_path
    end
  end

  def cancel
    @friendship = current_user.pending_friendships.find(params[:id])
    if @friendship
      @friendship.destroy
      flash[:notice] = "Friendship request canceled"
      redirect_to manage_friends_path
    else
      flash[:error] = "Unable to cancel Friendship request"
      redirect_to manage_friends_path
    end
  end

  def remove
    @friendship = current_user.friendships.find(params[:id])
    if @friendship
      @invers_friendsip = current_user.inverse_friendships.find_by_user_id(@friendship.friend.id)
      @friendship.destroy
      @invers_friendsip.destroy
      flash[:notice] = "Friend removed"
      redirect_to manage_friends_path
    else
      flash[:error] = "Unable to remove friend"
      redirect_to manage_friends_path
    end
  end

end
