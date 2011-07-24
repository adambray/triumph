Rails.application.routes.draw do |map|
  resources :achievements, :controller => 'triumph/achievements'
end