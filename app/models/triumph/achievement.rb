module Triumph
  class Achievement < ActiveRecord::Base

    unloadable
    
    has_many :completed_achievements, :class_name => "Triumph::CompletedAchievement"
    has_many :achievement_conditions, :class_name => "Triumph::AchievementCondition"
  
    def self.check_achievements_for(object)
    
      user = object.user
      object_class = object.class.to_s.underscore.downcase
      potential_achievements = Triumph::Achievement.where("observe_class = ?", object_class)    
    
      potential_achievements.each do |achievement|
        total = user.send(object.class.to_s.pluralize.underscore.to_sym).count
        if total >= achievement.quantity
          grant_achievement = true
          achievement.achievement_conditions.each do |condition|
            if !condition.total_value.send(condition.total_operator.to_s, user.send(object.class.to_s.pluralize.underscore.to_sym).select{|o| o.send(condition.comparison_attribute.to_s).count.send(condition.comparison_operator.to_s, condition.comparison_value.to_s)})
              grant_achievemnt = false
            end            
          end
          user.grant_achievement(achievement) if grant_achievement
        end
      end
    end
  
  end
end