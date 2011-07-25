module Triumph
  class AchievementCondition < ActiveRecord::Base

    unloadable
    
    belongs_to :achievement
  
  end
end