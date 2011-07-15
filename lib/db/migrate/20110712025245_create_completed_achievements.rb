class CreateCompletedAchievements < ActiveRecord::Migration
  def self.up
    create_table :completed_achievements do |t|
      t.int     :achievement_id
      t.integer :user_id      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :completed_achievements
  end
end


