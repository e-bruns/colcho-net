class Room < ApplicationRecord
  belongs_to :user
  
  def complete_name
    "#{title}, #{location}"
  end
end
