class UserSession < ApplicationRecord

  validates :email, presence: true, format: { with: /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/ }
  validates :password, presence: true, length: { maximum: 72 }

  def persisted?
    false
  end

end