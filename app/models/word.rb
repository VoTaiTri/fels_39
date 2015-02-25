class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  validates :category_id, presence: true
  validates :japanese, presence: true, length: {maximum: 256}
  default_scope -> {order(japanese: :asc)}

  def correct_answer
    self.answers.find_by(correct: true)
  end
end
