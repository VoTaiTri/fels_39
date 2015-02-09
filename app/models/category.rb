class Category < ActiveRecord::Base
  has_many :word, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  validate :title, presence: true, length: {maximum: 256}
  validate :body, presence: true
end
