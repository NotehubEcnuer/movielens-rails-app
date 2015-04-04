class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :rating
      t.datetime :rated_at

      t.timestamps null: false
    end
  end
end
