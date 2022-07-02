class Review < ApplicationRecord
  POINTS ||= (1..5).to_a
  
  belongs_to :user
  belongs_to :room, :counter_cache => true
  #attr_accessor :points

  validates :user_id, uniqueness: { scope: :room_id }
  validates :points, :user_id, :room_id, presence: true
  validates :points, inclusion: { in: POINTS }

  def self.stars
    (average(:points) || 0).round
  end

  
end
