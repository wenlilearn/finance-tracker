class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_portfolio
    @stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end
end
