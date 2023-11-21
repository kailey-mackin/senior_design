class Quiz < ActiveRecord::Base
  has_many :responses
  has_and_belongs_to_many :sounds
  #belongs_to :user  Add this back in when we have users
end
