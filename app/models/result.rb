class Result < ActiveRecord::Base
  belongs_to :lesson, dependent: :destroy
end
