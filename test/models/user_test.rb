# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  age           :integer
#  gender        :string(1)
#  occupation_id :integer
#  zip_code      :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
