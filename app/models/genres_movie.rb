# == Schema Information
#
# Table name: genres_movies
#
#  id       :integer          not null, primary key
#  movie_id :integer
#  genre_id :integer
#

class GenresMovie < ActiveRecord::Base
  belongs_to :genre
  belongs_to :movie
end
