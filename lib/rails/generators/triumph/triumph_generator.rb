require 'rails/generators'

class TriumphGenerator < Rails::Generators::Base
  
  source_root File.expand_path('../templates', __FILE__)
  
  def generate
    copy_file "20110711040135_create_achievements.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_achievements.rb"
    copy_file "20110712025245_create_completed_achievements.rb", "db/migrate/#{(Time.now + 5.seconds).utc.strftime("%Y%m%d%H%M%S")}_create_completed_achievements.rb"
    copy_file "20110712033351_create_achievement_conditions.rb", "db/migrate/#{(Time.now + 10.seconds).utc.strftime("%Y%m%d%H%M%S")}_create_achievement_conditions.rb"
  end

  # Every method that is declared below will be automatically executed when the generator is run
  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/triumph.rb'
  end


end