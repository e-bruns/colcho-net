class AddCounterCacheToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :reviews_count, :integer
  end
end
