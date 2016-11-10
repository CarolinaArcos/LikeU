class User < ApplicationRecord
  has_many :answers
  belongs_to :team
  before_create :set_active_default
  before_create :encrypt

  validates :email, uniqueness: true,
                    format: {
                      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
                    }


  def self.authenticate(email, password)
    user = User.find_by(email: email) #If exist: ok, if not: nil
    return nil if user.nil?
    return nil unless user.password == Digest::SHA2.hexdigest(password)
    return user
  end

  def get_last_answer
    return self.answers.last
  end

  def section_per_day
    diff= 7.0/self.complete_in_days.to_f
    sections_per_day = Array.new(self.complete_in_days, diff.to_i)
    sections_per_day[0] = (sections_per_day.first + 1) unless diff.integer?
    return sections_per_day
  end

  def next_section
  end

  def can_continue?
     return true if get_last_answer.option.question.next.section.eql? get_last_answer.option.question.section
     self.answered_at = Date.today
     self.save!
     
     return false
  end

  private

  # SHA1: kind of encryption algorithm
  def encrypt
    self.password = Digest::SHA2.hexdigest(self.password)
  end

  def set_active_default
    self.is_active = false
  end

end
