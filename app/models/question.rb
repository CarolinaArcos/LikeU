class Question < ApplicationRecord

  YES_NO_QUESTION = "yes_no"
  VOLUME_QUESTION = "volume"

  DEFINITELY_OPTION_1 = "definitely_opt_1"
  MAYBE_OPTION_1 = "maybe_option_1"
  NEUTRAL = "neutral"
  MAYBE_OPTION_2 = "maybe_option_2"
  DEFINITELY_OPTION_2 = "definitely_opt_2"

  has_many :options
  belongs_to :section

  validates :kind, inclusion: { in: %w(yes_no volume)}

  #Return the next question adding 1 to the id
  def next
    return Question.find_by(id: self.id + 1)
  end
end
