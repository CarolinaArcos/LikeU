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


  private

  # SHA1: kind of encryption algorithm
  def encrypt
    self.password = Digest::SHA2.hexdigest(self.password)
  end

  def set_active_default
    self.is_active = false
  end



end
