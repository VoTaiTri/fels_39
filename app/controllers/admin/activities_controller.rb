class Admin::ActivitiesController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @activities = @user.user_activity.paginate page: params[:page], per_page: 10
  end
end