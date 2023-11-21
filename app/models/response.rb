class Response < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :sound
  #belongs_to :user  Add this back in when we have users
end
