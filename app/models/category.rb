class Category < ActiveRecord::Base
  has_many :connects
  has_many :clips, through: :connects
end
