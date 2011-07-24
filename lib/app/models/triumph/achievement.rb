module Triumph
  class Achievement < ActiveRecord::Base

    unloadable
    
    has_many :completed_achievements
  
    def self.check_achievements_for(object)
    
      user = object.user
      object_class = object.class.to_s.underscore.downcase
      potential_achievements = Achievement.where("observe_class = ?", object_class)    
    
      potential_achievements.each do |achievement|
        total = user.send(object.class.to_s.pluralize.underscore.to_sym).where(achievement.conditions).count
        if total >= achievement.quantity
          user.grant_achievement(achievement)
        end
      end
    end
  
  end
end