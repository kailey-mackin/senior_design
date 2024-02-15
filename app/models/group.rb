# frozen_string_literal: true

class Group  < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  has_and_belongs_to_many :sounds, :join_table => "groups_users"

  before_save :generate_join_token

  def generate_join_token
    join_token = SecureRandom.hex(5)
    if Group.exists?(join_token: join_token)
      generate_join_token
    else
      self.join_token = join_token
    end
  end

  def self.find_group(join_token)
    Group.exists?(join_token: join_token)
  end
end
