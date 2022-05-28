class User < ApplicationRecord
  validates :full_name, :location, presence: true
  validates :password, length: { maximum: 72 }, confirmation: true
  validates :bio, length: { minimum: 10 }, allow_blank: false
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/ }
  
  has_secure_password

  before_create :generate_token

  def generate_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ''
    save!
  end

  def confirmed?
    confirmed_at.present?
  end
end
