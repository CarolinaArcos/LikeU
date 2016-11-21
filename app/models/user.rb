class User < ApplicationRecord
  has_many :answers
  belongs_to :team
  before_create :set_active_default
  before_create :encrypt
  before_create :generate_figure_identifier

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

  # Return the las answer saved
  def get_last_answer
    return self.answers.last
  end

  # Return the numer od sections the user resolve each day
  def section_per_day
    diff= 6.0/self.complete_in_days.to_f

    # sections_per_day is created with complete_in_days positions with diff as default vale
    sections_per_day = Array.new(self.complete_in_days, diff.to_i)

    # With diff.integer? ask if the number has decimal part
    sections_per_day[0] = (sections_per_day.first + 1) unless diff.integer?
    return sections_per_day
  end

  # Return false if the next question is in the same section, and true otherwise
  def finished_section?
    return true unless get_last_answer.option.question.next.section.eql? get_last_answer.option.question.section
    return false
  end

  def finished_test?
    unless get_last_answer.nil?
      return true if get_last_answer.option.question.next.nil?
    end
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

  def deterinate_progress
    sections = Section.count
    user_section = get_last_answer.question.section.id unless get_last_answer.nil?
    user_section ||= 0
    return @progress = (user_section * 100) / sections
  end

  def results
    result = {}

    result[:text] =  %x(#{Rails.root}/bin/python/results #{Rails.root} #{self.id} #{self.figure})
    result[:url_graph] =  "http://127.0.0.1:3000/results/results_graph/#{self.figure}"
    result[:url_table] =  "http://127.0.0.1:3000/results/results_table/#{self.figure}"
    return result
  end

  def show_figure?
    return self.team.all_completed?
  end

  # Generate an unique identifier for the figure using Universal Unique identifier
  # Ends the loop when the identifier doesn't exist
  def generate_figure_identifier
    loop do
      self.figure = "#{SecureRandom.uuid}.png"
      break unless User.exists? figure: self.figure
    end
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
