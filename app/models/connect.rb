class Connect < ActiveRecord::Base
  belongs_to :category
  belongs_to :clip
end
