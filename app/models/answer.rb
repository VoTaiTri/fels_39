class Answer < ActiveRecord::Base
  belongs_to :word
  validate :content, presence: true, length: {maximum: 256}
end
