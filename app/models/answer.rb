class Answer < ActiveRecord::Base
  belongs_to :word
  validates :content, presence: true, length: {maximum: 256}
end
