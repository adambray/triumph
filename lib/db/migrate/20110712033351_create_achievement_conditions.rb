class CreateAchievementConditions < ActiveRecord::Migration
  def self.up
    create_table :achievement_conditions do |t|
      t.int     :achievement_id
      t.string  :comparison_attribute
      t.string  :comparison_operator
      t.string  :comparison_value
      t.string  :total_operator
      t.string  :total_value
      
      t.timestamps
    end
  end

  def self.down
    drop_table :achievement_achievements
  end
end