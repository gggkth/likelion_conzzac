class Clip < ActiveRecord::Base
  #source와 n:1
  belongs_to :source
  
  #uploader와 n:1
  belongs_to :uploader
  
  #category와 n:m through connects
  has_many :connects
  has_many :categories, through: :connects
  
  #user와 n:m through scrap, frequent
  has_many :scraps
  has_many :scrap_users, through: :scraps, source: :user
  has_many :frequents
  has_many :frequent_users, through: :frequents, source: :user
end
