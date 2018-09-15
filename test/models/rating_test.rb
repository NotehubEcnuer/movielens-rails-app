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

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
