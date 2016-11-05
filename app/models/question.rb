class Question < ApplicationRecord

  YES_NO_QUESTION = "yes_no"
  VOLUME_QUESTION = "volume"

  has_many :options
  belongs_to :section

  validates :kind, inclusion: { in: %w(yes_no volume)}
end
