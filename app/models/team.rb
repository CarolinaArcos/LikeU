class Team < ApplicationRecord
  has_one :leader, class_name: "User"
  has_many :users

  validates :leader_id, absence: true
end
