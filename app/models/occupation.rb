# == Schema Information
#
# Table name: occupations
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Occupation < ActiveRecord::Base
  has_many :users
end
