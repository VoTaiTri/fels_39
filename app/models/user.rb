class User < ActiveRecord::Base
  attr_accessor :remember_token
  has_many :active_relationships,  class_name:  'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}, 
                                    format: {with: VALID_EMAIL_REGEX}, 
                                    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}

  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user 
    active_relationships.create followed: other_user
    self.activities.create target_id: other_user.id, action_type: "follow"
  end

  def unfollow other_user
    active_relationships.find_by(followed: other_user).destroy
    self.activities.create target_id: other_user.id, action_type: "unfollow"
  end

  def following? other_user
    following.include? other_user
  end

  def feed
    following_ids = self.following.pluck :id
    Activity.where user_id: following_ids + [self.id]
  end

  def user_activity
    Activity.where user: self
  end
end