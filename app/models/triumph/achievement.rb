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
            total_value = condition.total_value
            objects = user.send(object.class.to_s.pluralize.underscore.to_sym)
            
            unless objects.empty?
              case objects.first.send(condition.comparison_attribute)
              when Integer
                comparison_value = condition.comparison_value.to_i
              when Float
                comparison_value = condition.comparison_value.to_f
              when TrueClass, FalseClass
                comparison_value = condition.comparison_value == "true" ? true : false
              end
            end
                
            objects_meeting_condition = objects.select{|o| o.send(condition.comparison_attribute).send(condition.comparison_operator, comparison_value)}.count

            if total_value.send(condition.total_operator.to_s, objects_meeting_condition)
              grant_achievemnt = false
            end            
          end
          user.grant_achievement(achievement) if grant_achievement
        end
      end
    end
  
  end
end