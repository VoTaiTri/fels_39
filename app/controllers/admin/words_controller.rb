class Admin::WordsController < ApplicationController
  def index
    if params[:category_id].blank?
      @words = Word.paginate page: params[:page], per_page: 100
    else
      category = Category.find params[:category_id]
      @words = category.words.paginate page: params[:page], per_page: 100
    end
  end

  def new
    if params[:category_id].blank?
      @word = Word.new
    else
      @category = Category.find params[:category_id]
      @word = @category.words.new
    end
    4.times {@word.answers.build}
  end

  def edit
    if params[:category_id].blank?
      @word = Word.find params[:id]
    else
      @category = Category.find params[:category_id]
      @word = @category.words.find params[:id]
    end
  end

  def create
    if params[:category_id].blank?
      @word = Word.new word_params
    else
      @category = Category.find params[:category_id]
      @word = @category.words.new word_params
    end
      
    if @word.save
      flash[:success] = "New word created!"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    @word = Word.find params[:id]
    if @word.update_attributes word_params
      flash[:success] = "Word updated"
      redirect_to admin_words_url
    else
      render :edit
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = "Word deleted"
    redirect_to admin_words_url
  end

  private
  def word_params
    params.require(:word).permit :japanese, :category_id, answers_attributes: [:id, :content, :correct, :_destroy] 
  end
end