require 'rails/generators'

class AchievementObserverGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  argument :model_name, :type => :string, :description => "The name of the model to observe."
  
  def generate
    empty_directory "app/models"
    template "achievement_observer.rb", "app/models/triumph/#{model_name.underscore}_observer.rb"
  end
  
end
