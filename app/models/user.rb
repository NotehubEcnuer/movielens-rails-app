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

class User < ActiveRecord::Base
  belongs_to :occupation
  has_many :ratings
  has_many :movies, through: :ratings
end
