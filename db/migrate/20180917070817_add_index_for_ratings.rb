class AddIndexForRatings < ActiveRecord::Migration
  def change
    add_index :ratings, [:user_id, :movie_id], unique: true
  end
end
