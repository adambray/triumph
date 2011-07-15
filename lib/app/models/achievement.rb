class Achievement < ActiveRecord::Base

  has_many :completed_achievements
  
  def self.check_achievements_for(object)
    
    user = object.user
    object_class = object.class.to_s.underscore.downcase
    potential_achievements = Achievement.where("observe_class = ?", object_class)    
    
    potential_achievements.each do |achievement|
      total = user.send(object.class.to_s.pluralize.underscore.to_sym).where(achievement.conditions)
      if total > achievment.quantity
        user.grant_achievment(achievement)
      end
    end
  end
  
end
