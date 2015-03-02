class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :lesson_not_learned, only: :show

  def create
    @category = Category.find params[:category_id]
    @lesson = current_user.lessons.build  category: @category
    
    if @lesson.save
      flash[:success] = "Start lesson!"
      redirect_to [@category, @lesson]
    else
      flash[:error] = "Start lesson failed."
      render "static_pages/home"
    end
  end

  def show
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.find params[:id]
    @questions = @category.words.sample 20
  end

  def update
    @lesson = Lesson.find params[:id]

    if @lesson.update_attributes lesson_answers
      flash[:success] = "Lesson end!"
      redirect_to categories_path
    else
      flash[:error] = "Lesson failed!"
      redirect_to categories_path
    end
  end

  private
    def lesson_answers
      params.require(:lesson).permit(:words, :answers)
    end

    def lesson_not_learned
      @lesson = Lesson.find params[:id]
      redirect_to categories_path unless @lesson.answers.nil?
    end
end