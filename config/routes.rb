Rails.application.routes.draw do
  root :to => redirect('/about')
  resources :responses
  resources :quizzes
  resources :sounds
  resources :users
  match '/login', to: 'sessions#new', via: :get, :as => 'login'
  match '/about', to: 'users#about', via: :get, :as => 'about'
  match '/logout', to: 'sessions#destroy', via: :delete, :as => 'logout_path'

  get 'data/audio/:filename', to: 'sounds#audio', as: 'audio'
end
