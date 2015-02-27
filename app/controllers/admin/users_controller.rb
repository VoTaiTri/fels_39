class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  
  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page], per_page: 10
    @total = User.all.count
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "New user created!"
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = "User deleted!"
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,:password_confirmation
  end

end