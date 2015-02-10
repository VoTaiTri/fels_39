class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answer, dependent: :destroy
  validate :category_id, presence: true
  validate :vietnamese, presence: true, length: {maximum: 256}
  validate :japanese, presence: true, length: {maximum: 256}
  default_scope -> {order(created_at: :asc)}
end
