class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    if params[:category_id].blank?
      @words = Word.paginate page: params[:page], per_page: 100
    else
      category = Category.find params[:category_id]
      @words = category.words.paginate page: params[:page], per_page: 100
    end
  end
end
