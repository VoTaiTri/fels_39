class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  
  validates :category_id, presence: true
  validates :japanese, presence: true
  validates_uniqueness_of :japanese, scope: :category_id, case_sensitive: false

  accepts_nested_attributes_for :answers, reject_if: lambda {|a| a[:content].blank?}, allow_destroy: true

  def correct_answer
    self.answers.find_by correct: true
  end
end