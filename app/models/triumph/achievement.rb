module Triumph
  class Achievement < ActiveRecord::Base

    unloadable
    
    has_many :completed_achievements, :class_name => "Triumph::CompletedAchievement"
    has_many :achievement_conditions, :class_name => "Triumph::AchievementCondition"
  
  
    # This method is currently long, and I plan to refactor much of it tomorrow
    # I plan to move much of the checking logic into the CompletedAchievement class
    def self.check_achievements_for(object)
    
      user = object.user
      object_class = object.class.to_s.underscore.downcase
      potential_achievements = Triumph::Achievement.where("observe_class = ?", object_class)    
    
      potential_achievements.each do |achievement|
        total = user.send(object.class.to_s.pluralize.underscore.to_sym).count
        if total >= achievement.quantity
          condition_results = []
          achievement.achievement_conditions.each do |condition|
            condition.check(object)
          end
          user.grant_achievement(achievement) unless condition_results.include? false
        end
      end
    end
  
  end
end