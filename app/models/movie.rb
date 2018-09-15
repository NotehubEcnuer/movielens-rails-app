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
end
