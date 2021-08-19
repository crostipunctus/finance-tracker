class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  
  def under_stock_limit? 
    stocks.count < 10
  end


  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name 
    "Anonymous"
  end

  def friend_already_added?(friend_email)
    friend = User.where(email: friend_email)
    return false unless friend
    friends.where(id: friend.ids).exists?
  end

  def friend_is_you?(friend_email)
    friend = User.where(email: friend_email)
    return false if friend == User
  end

  def self.search(params)
    params.strip! 
    to_send_back = (email_matches(params) + first_name_matches(params) + last_name_matches(params)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.email_matches(params)
    matches('email', params)
  end

  def self.first_name_matches(params)
    matches('first_name', params)
  end

  def self.last_name_matches(params)
    matches('last_name', params)
  end



  def self.matches(field_name, params)
    where("#{field_name} like ?", "%#{params}%")
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id }
  end
    
end
