Rails.application.routes.draw do |map|

  map.resources :achievements,  :controller => 'triumph/achievements', :path_prefix => "/triumph", :name_prefix => "triumph_"

end
