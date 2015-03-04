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
      @activity = current_user.activities.create target_id: @lesson.id, action_type: "learn"
      @result = Result.new lesson: @lesson
      redirect_to @result if @result.save
    else
      flash[:error] = "Lesson failed!"
      redirect_to categories_path
    end
  end

  private
    def lesson_answers
      params.require(:lesson).permit :word_ids, :answer_ids
    end

    def lesson_not_learned
      @lesson = Lesson.find params[:id]
      unless @lesson.answer_ids.blank?
        @result = Result.find_by lesson: @lesson
        redirect_to @result
      end
    end
end