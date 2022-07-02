class Room < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user

  scope :most_recent, -> { order('created_at DESC') }
  
  def complete_name
    "#{title}, #{location}"
  end

  def self.search(query)
    if query.present?
      where(['location LIKE :query OR
              title LIKE :query OR
              description LIKE :query', :query => "%#{query}%"])
    else
      where(nil)
    end
  end
end
