class Activity < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  def message
    case self.action_type.downcase
    when "learn"
      @lesson = Lesson.find self.target_id
      return "#{self.user.name} learned in #{@lesson.category.title} "
    when "follow"
      @followed_user = User.find self.target_id
      return "#{self.user.name} followed #{@followed_user.name}"
    end
  end
end
