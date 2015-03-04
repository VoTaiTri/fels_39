class Activity < ActiveRecord::Base
  belongs_to :user

  def message
    case self.action_type.downcase
    when "learn"
      lesson = Lesson.find self.target_id
      return "#{self.user.name} learned #{lesson.score}/20 in #{lesson.category.title}"
    when "follow"
      followed_user = User.find self.target_id
      return "#{self.user.name} followed #{followed_user.name}"
    when "unfollow"
      unfollowed_user = User.find self.target_id
      return "#{self.user.name} unfollowed #{followed_user.name}"
    end
  end
end
