class Achievement < ActiveRecord::Base

  has_many :conditions
  has_many :completed_achievements
  
end
