class FollowingsController < ApplicationController
  def index
    @title = "Following"
    @user  = User.find_by params[:id]
    @users = @user.followers.paginate page: params[:page], per_page: 10
  end
end