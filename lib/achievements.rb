module Achievements
  
  def self.included(base)
    base.class_eval do
      #for some reason, this is not adding the proper association to the users model
      # when I do 'include Achievemnts', though everything else works as expected.
      # For now, I'm manually adding the 'has_many :completed_achievements' to the user
      # model in my sample app, but I need to figure this out.
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