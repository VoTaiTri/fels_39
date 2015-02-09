class Lesson < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
