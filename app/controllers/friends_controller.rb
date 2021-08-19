class FriendsController < ApplicationController

  def search_db
    if params[:user].present?
      @friends = User.search(params[:user])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'friends/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No such user. Please enter a valid email id."
          format.js { render partial: 'friends/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter an email id"
        format.js { render partial: 'friends/result' }
      end
    end
  end
  
end