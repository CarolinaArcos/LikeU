class Option < ApplicationRecord
  belongs_to :question

  DEFINITELY_OPTION_A = "definitely_opt_a"
  MAYBE_OPTION_A = "maybe_option_a"
  NEUTRAL = "neutral"
  MAYBE_OPTION_B = "maybe_option_b"
  DEFINITELY_OPTION_B = "definitely_opt_b"

  validates :body, inclusion: { in: %w(definitely_opt_a maybe_option_a neutral maybe_option_b definitely_opt_b)}

end
