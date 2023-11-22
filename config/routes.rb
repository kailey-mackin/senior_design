Rails.application.routes.draw do
  root :to => 'pages#about'
  resources :responses
  resources :quizzes
  resources :sounds
  resources :users
  match '/login', to: 'sessions#new', via: :get, :as => 'login'
  match '/login/create', to: 'sessions#create', via: :post, :as => 'sessions'
  match '/about', to: 'users#about', via: :get, :as => 'about'
  match '/logout', to: 'sessions#destroy', via: :delete, :as => 'logout_path'
  get 'data/audio/:filename', to: 'sounds#audio', as: 'audio'
end
