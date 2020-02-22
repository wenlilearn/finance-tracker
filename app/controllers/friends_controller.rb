class FriendsController < ApplicationController
  def remove
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])

    friendship.destroy if friendship    
    flash[:notice] = "Friend was successfully removed"
    redirect_to friends_path
  end

  def search
    if params[:friend].present?
      name_or_email = params[:friend]
      @friends = User.search(name_or_email).reject { |friend| friend.id == current_user.id }
      if @friends
        respond_to do |format|
          format.js { render "friends/_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid username or email to search"
          format.js { render "friends/_result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a username or email to search"
        format.js { render "friends/_result" }
      end
    end
  end

  def create
    Friendship.create(user: current_user, friend: User.find(params[:id]))
    flash[:notice] = "You have successfully added a friend!"
    redirect_to friends_path
  end
end