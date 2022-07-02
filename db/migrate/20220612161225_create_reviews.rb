class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :points

      t.timestamps
    end
    
    add_index(:reviews, [:user_id, :room_id], unique: true)
  end
end
