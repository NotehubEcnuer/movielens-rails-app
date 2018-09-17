# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  release_date :date
#

class Movie < ActiveRecord::Base
  has_many :ratings

  has_many :genres_movies
  has_many :genres, through: :genres_movies

  def jaccard_sim(other_movie)
    # 假设评分大于等于3的为喜欢
    other_user_ids = other_movie.ratings.where("rating >= 3").pluck(:user_id)
    user_ids       = self.ratings.where("rating >= 3").pluck(:user_id)
    
    # 交集数量
    intersection = (other_user_ids & user_ids).count

    # 并集数量
    union        = (other_user_ids | user_ids).count

    return 0 if union.zero?
    intersection.to_f / union.to_f
  end

  def recommendation_movies(limit: 10)
    movie_with_sim_scores = Movie.where("id != ?", self.id).map do |movie|
      {movie: movie, sim_score: jaccard_sim(movie)}
    end
    movie_with_sim_scores.sort_by { |h| 1 - h[:sim_score] }[0, limit]
  end
end
