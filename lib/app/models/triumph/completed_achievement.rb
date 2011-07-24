module Triumph
  class CompletedAchievement < ActiveRecord::Base

  unloadable

  belongs_to :user
  belongs_to :achievement

  end  
end
