class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  def score
    return 0 if self.answer_ids.blank?

    words = Word.find self.word_ids.split(",")
    answers = Answer.find self.answer_ids.split(",")
    correct_answers = words.map(&:correct_answer).flatten
    
    results = answers & correct_answers
    results.count
  end
end
