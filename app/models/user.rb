class User < ActiveRecord::Base
  before_save {|user| user.email=user.email.downcase}
  before_save :create_session_token

  has_secure_password
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum:8}
  validates :password_confirmation, presence: true

  has_and_belongs_to_many :quizzes

  private
  def create_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end
end
