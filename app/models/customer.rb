class Customer < ApplicationRecord
  validates :username, presence: true,  uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :password, length: { minimum: 6 }

  validate :password_contains_number

  def password_contains_number
    return if password.count("0-9") > 0
    errors.add(:password, "must contain at least one number")
  end

end
