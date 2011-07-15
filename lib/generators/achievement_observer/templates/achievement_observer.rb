class <%= model_name %>Observer < ActiveRecord::Observer
  observe :<%= model_name.downcase.underscore %>
  
  def after_save(<%= model_name.downcase.underscore %>)
    <%= class_name %>.award_achievements_for(<%= model_name.downcase.underscore %>.achievable) if ('your conditions here')
  end
end