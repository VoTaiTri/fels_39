class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answer, dependent: :destroy
  validates :category_id, presence: true
  validates :japanese, presence: true, length: {maximum: 256}
  default_scope -> {order(created_at: :asc)}
end
