class FollowingsController < ApplicationController
  def index
    @title = "Following"
    @user  = User.find params[:user_id]
    @users = @user.following.paginate page: params[:page], per_page: 10
  end
end