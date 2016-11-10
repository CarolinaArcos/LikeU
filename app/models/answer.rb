class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :option
  belongs_to :question

  class << self
    def create_or_initialize(question, user)
      where(question: question, user: user).first_or_initialize
    end
  end
end
