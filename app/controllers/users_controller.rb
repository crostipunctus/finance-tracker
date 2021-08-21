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

  def refresh
    @tracked_stocks = current_user.stocks
    @tracked_stocks.each do |stock|
      stock = Stock.new_lookup(stock.ticker)
      s = Stock.find_by(ticker: stock.ticker)
      s.update(last_price: stock.last_price)
    end
    @refreshed_stocks = current_user.stocks
    @user = current_user
    respond_to do |format|
      format.js { render partial: 'stocks/list' }
    end
  end
  
 
end