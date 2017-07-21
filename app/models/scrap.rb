class Scrap < ActiveRecord::Base
	belongs_to :clip
	belongs_to :user
end
