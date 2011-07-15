class <%= model_name %>Observer < ActiveRecord::Observer
  observe :<%= model_name.underscore %>
  
  def after_save(<%= model_name.underscore %>)
    Achievement.check_achievements_for(<%= model_name.underscore %>)
  end
end