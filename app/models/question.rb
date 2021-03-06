class Question < ApplicationRecord

  #Kinds of possible questions
  YES_NO_QUESTION = "yes_no"

  has_many :options
  belongs_to :section

  validates :kind, inclusion: { in: %w(yes_no volume)}

  #Return the next question adding 1 to the id
  def next
    return Question.find_by(id: self.id + 1)
  end
end
