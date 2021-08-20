class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @my_friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @user_friends = @user.friends
    @tracked_stocks = @user.stocks
 

  end
  
 
end