class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  validates :full_name, :location, presence: true
  validates :password, length: { maximum: 72 }, confirmation: true
  validates :bio, length: { minimum: 10 }, allow_blank: false
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/ }
  
  has_secure_password

  before_create :generate_token

  scope :confirmed, -> { where('confirmed_at IS NOT NULL') }

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

  def self.authenticate(email, password)
    confirmed.find_by_email(email).try(:authenticate, password)
  end

end
