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

  def recommend_by_matrix(limit: 10)
    Movie.find_by_sql(<<~SQL)
      SELECT m.*, matrix.sim_score
        FROM item_item_matrix AS matrix
             INNER JOIN movies AS m ON m.id = matrix.v_id
       WHERE matrix.u_id = #{self.id}
    ORDER BY matrix.sim_score DESC
       LIMIT #{limit}
    SQL
  end

  def recommend_by_sql(limit: 10)
    Movie.find_by_sql(<<~SQL)
        SELECT array_length(m.like_user_ids & movies.like_user_ids, 1) / array_length(m.like_user_ids | movies.like_user_ids, 1)::float AS score,
               m.* 
          FROM movies 
               INNER JOIN movies AS m ON m.id != #{self.id} 
         WHERE movies.id = #{self.id}  
      ORDER BY 1 DESC 
         LIMIT #{limit}
    SQL
  end

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

  def pearson_sim(other_movie)
    other_user_ratings = other_movie.ratings.map { |r| [r.user_id, r.rating] }.to_h
    user_ratings       = self.ratings.map { |r| [r.user_id, r.rating] }.to_h
    
    # 有共同评价的用户
    union_user_ids = other_user_ratings.keys & user_ratings.keys
    n = union_user_ids.count
    return 0 if n == 0

    u = other_user_ratings.values_at(*union_user_ids)
    v = user_ratings.values_at(*union_user_ids)

    sum_u = u.sum
    sum_v = v.sum 

    sum_u_sq = u.map { |x| x*x }.sum 
    sum_v_sq = v.map { |x| x*x }.sum

    prod_sum = u.zip(v).map { |x, y| x*y }.sum
    num = prod_sum - ((sum_u * sum_v) / n.to_f)
    den = Math.sqrt((sum_u_sq - (sum_u * sum_u) / n.to_f) * (sum_v_sq - (sum_v * sum_v) / n.to_f))
    return 0 if den == 0
    [num / den, 1].min
  end

  def cosine_sim(other_movie)
    other_user_ratings = other_movie.ratings.map { |r| [r.user_id, r.rating] }.to_h
    user_ratings       = self.ratings.map { |r| [r.user_id, r.rating] }.to_h

    # 有共同评价的用户
    union_user_ids = other_user_ratings.keys & user_ratings.keys
    return 0 if union_user_ids.count == 0

    u = other_user_ratings.values_at(*union_user_ids)
    v = user_ratings.values_at(*union_user_ids)

    dot_product = u.zip(v).map { |a, b| a*b }.sum

    magnitude_u = Math.sqrt(u.map { |x| x*x }.sum)
    magnitude_v = Math.sqrt(v.map { |x| x*x }.sum)

    cosine_similarity = dot_product.to_f / (magnitude_v * magnitude_u)
  end

  def recommendation_movies(limit: 10, using: :jaccard_sim)
    movie_with_sim_scores = Movie.where("id != ?", self.id).map do |movie|
      {movie: movie, sim_score: public_send(using, movie) }
    end
    movie_with_sim_scores.sort_by { |h| 1 - h[:sim_score] }[0, limit]
  end
end
