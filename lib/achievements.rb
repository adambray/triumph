module Achievements
  
  def self.included(base)
    base.class_eval do
      has_many :completed_achievements
    end
  end
  
  def grant_achievement(achievement)
    unless self.has_achievement?(achievement)
      CompletedAchievement.create!(:achievement_id => achievement.id, :user_id => self.id)
    end
  end
  
  def has_achievement?(achievement)
    CompletedAchievement.where("achievement_id = ?", achievement.id).count >= 1     
  end
  
end