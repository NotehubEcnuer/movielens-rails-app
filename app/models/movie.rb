class Movie < ActiveRecord::Base
  has_many :ratings

  has_many :genres_movies
  has_many :genres, through: :genres_movies
end
