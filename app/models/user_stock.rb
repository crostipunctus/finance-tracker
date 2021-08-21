class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  def self.user_stock_exists?(user, user_stock)
    where(user_id: user, stock_id: user_stock).first
  end


end
