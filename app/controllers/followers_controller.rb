class FollowersController < ApplicationController
  def index
    @title = "Followers"
    @user  = User.find_by params[:id]
    @users = @user.followers.paginate page: params[:page], per_page: 10
  end
end