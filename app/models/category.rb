class Category < ActiveRecord::Base
  has_many :word, dependent: :destroy
  has_many :lesson, dependent: :destroy
  validates :title, presence: true, length: {maximum: 256}
  validates :body, presence: true
end
