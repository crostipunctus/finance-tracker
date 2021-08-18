class FriendshipsController < ApplicationController
  def index  

  end

  def create  
    friend = User.find(params[:friend])
    @friendship = Friendship.create(user: current_user, friend: friend)

    flash[:notice] = "#{friend.first_name} was succesfully added to your friend list"
    redirect_to friends_path
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user, friend_id: friend.id).first
    friendship.destroy 
    flash[:notice] = "You are no longer friends with #{friend.first_name}"
    redirect_to friends_path
  end
end
