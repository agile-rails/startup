Rails.application.routes.draw do
  root :to => 'portal#page'

  Agile.routes
  put '/portal/process_login' => 'portal#process_login'

  get '*path' => 'portal#page'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
