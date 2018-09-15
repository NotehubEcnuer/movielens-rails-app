# == Schema Information
#
# Table name: genres
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Genre < ActiveRecord::Base
  has_many :genres_movies
  has_many :movies, through: :genres_movies
end
