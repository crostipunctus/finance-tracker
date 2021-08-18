class FriendsController < ApplicationController

  def search
    if params[:user].present?
      @friend = User.where(email: params[:user]).first
      if @friend != current_user
        if @friend
          respond_to do |format|
            format.js { render partial: 'friends/result' }
          end
        else
          respond_to do |format|
            flash.now[:alert] = "Please enter a valid email id"
            format.js { render partial: 'friends/result' }
          end
        end
      else  
        respond_to do |format|
          flash.now[:alert] = "You cannot befriend yourself"
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