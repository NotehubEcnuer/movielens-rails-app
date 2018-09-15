# == Schema Information
#
# Table name: ratings
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  movie_id :integer
#  rating   :integer
#  rated_at :datetime
#

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
end
