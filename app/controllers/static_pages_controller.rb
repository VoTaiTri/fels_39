class StaticPagesController < ApplicationController
  def home
    @activities = current_user.feed.paginate page: params[:page]
  end

  def help
  end

  def about
  end

  def contact
  end
end
