class Team < ApplicationRecord
  has_one :leader, class_name: "User"
  has_many :users

  validates :leader_id, absence: true

  # Determinates if all the users in the team had finished the test
  def all_completed?
    self.users.each do | u |
      return false unless u.finished_test?
    end
    return true
  end

end
