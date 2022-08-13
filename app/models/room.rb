class Room < ApplicationRecord
  extend FriendlyId

  #attr_accessor :description, :location, :title, :picture

  has_many :reviews, dependent: :destroy
  belongs_to :user
  
  scope :most_recent, -> { order('created_at DESC') }

  validates_presence_of :title, :slug
  friendly_id :title, use: [:slugged, :history, :finders]

  # mount_uploader :picture, PictureUploader
  
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
