Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: Change the routing.
  # This is a temporary solution for the routing,
  # it will be changed in the future.
  root 'main_menu#index'

  get '/teacher_signin', to: 'main_menu#signin'

  get '/parent_signin', to: 'main_menu#signin'

  get '/teacher_signup', to: 'main_menu#signup'

  get '/parent_signup/', to: 'main_menu#signup'

  post '/parent_signin', to: 'parent#parent_signin'

  post '/parent_signup', to: 'parent#parent_signup'

  post '/teacher_signup', to: 'teacher#teacher_signup'

  post '/teacher_signin', to: 'teacher#teacher_signin'

end
