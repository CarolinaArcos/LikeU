class User < ApplicationRecord
  has_many :answers
  belongs_to :team
  before_create :set_active_default
  before_create :encrypt

  validates :email, uniqueness: true,
                    format: {
                      with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
                    }

  # Authenticate the User by email and password. If doesn't exist or the password
  # is wrong return false, else return the user
  def self.authenticate(email, password)
    user = User.find_by(email: email) #If exist: ok, if not: nil
    return nil if user.nil?
    return nil unless user.password == Digest::SHA2.hexdigest(password)
    return user
  end

  def get_last_answer
    return self.answers.last
  end

  # With diff.integer? ask if the number has decimal part
  def section_per_day
    diff= 7.0/self.complete_in_days.to_f
    sections_per_day = Array.new(self.complete_in_days, diff.to_i)
    sections_per_day[0] = (sections_per_day.first + 1) unless diff.integer?
    return sections_per_day
  end

  # Return false if the next question is in the same section, and true otherwise
  def finished_section?
    return true unless get_last_answer.option.question.next.section.eql? get_last_answer.option.question.section
    return false
  end

  # Return true if the next question is in the same section, otherwise change
  # answered_at to the current day and return false
  def can_continue?
    unless get_last_answer.option.question.next.nil?
     return true if get_last_answer.option.question.next.section.eql? get_last_answer.option.question.section
    end
    self.answered_at = DateTime.current
    self.save!

   return false
  end

  # Return true if there is an hour or more between answered_at and the current
  # time, return false otherwise
  def hour_completed?
    return true if (((DateTime.now - self.answered_at.to_datetime) * 24.0).to_f) > 1.0
    return false
  end

  # Return how many days have pass since the user started the poll
  def days_until_today
    return ((DateTime.now - self.started_at.to_datetime).to_f)
  end

  private

  # Encripts the password using SHA2 (a kind of encryption algorithm)
  def encrypt
    self.password = Digest::SHA2.hexdigest(self.password)
  end

  def set_active_default
    self.is_active = false
  end

end
