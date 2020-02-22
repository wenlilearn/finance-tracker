class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.find_stock_by_ticker(ticker_symbol)
    return false unless stock
    stocks.exists?(stock.id)
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      "Anonymous"
    end
  end

  def self.lookup(field, value)
    where("#{field} like ?", "%#{value}%")
  end

  def self.search(param)
    param.strip!

    results =
      (lookup("first_name", param) +
      lookup("last_name", param) +
      lookup("email", param)).uniq
    
    return nil if results.blank?
    results
  end

  def can_add_friend?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end
