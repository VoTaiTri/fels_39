class ResultsController < ApplicationController
  before_action :logged_in_user

  def show
    @result = Result.find params[:id]
    @lesson = @result.lesson
    @words = Word.find @lesson.words.split(",")
    @answers = Answer.find @lesson.answers.split(",")
  end
end
