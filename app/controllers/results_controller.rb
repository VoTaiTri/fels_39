class ResultsController < ApplicationController
  before_action :logged_in_user

  def show
    @result = Result.find params[:id]
    @lesson = @result.lesson
    @words = Word.find @lesson.word_ids.split(",")
    @answers = Answer.find @lesson.answer_ids.split(",")
  end
end
