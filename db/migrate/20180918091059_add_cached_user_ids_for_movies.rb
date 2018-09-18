class AddCachedUserIdsForMovies < ActiveRecord::Migration
  def change
    add_column :movies, :like_user_ids, :integer, :array => true, :default => '{}'
  end
end
