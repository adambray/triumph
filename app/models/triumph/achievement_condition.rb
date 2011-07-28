module Triumph
  class AchievementCondition < ActiveRecord::Base

    unloadable
    
    belongs_to :achievement
    
    def check(object)
      user = object.user
      object_class = object.class.to_s.underscore.downcase
      objects = user.send(object.class.to_s.pluralize.underscore.to_sym)
      
      unless objects.empty?
        case objects.first.send(comparison_attribute)
        when Integer
          comparison_value = comparison_value.to_i
        when Float
          comparison_value = comparison_value.to_f
        when TrueClass, FalseClass
          comparison_value = comparison_value == "true" ? true : false
        end
      end
          
      valid_objects = objects.select{|o| o.send(comparison_attribute).
                      send(comparison_operator, comparison_value)}
      num_valid_objects = valid_objects.count
      if !num_valid_objects.send(total_operator.to_s, total_value)
        false
      end            
      true
    end
  end
end