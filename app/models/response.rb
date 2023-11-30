class Response < ActiveRecord::Base
  belongs_to :sound
  has_and_belongs_to_many :quizzes, :join_table => "quizzes_responses"
  belongs_to :user
end
