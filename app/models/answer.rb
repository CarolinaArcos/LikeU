class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :question

  # Class Method
  # Search the answer of a specific user and question if exist, otherwise
  # creates one
  class << self
    def create_or_initialize(question, user)
      where(question: question, user: user).first_or_initialize
    end
  end
end
