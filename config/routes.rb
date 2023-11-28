Rails.application.routes.draw do
  root :to => 'pages#about'
  resources :responses
  resources :quizzes
  resources :sounds
  resources :users do
    get 'quiz_history', on: :collection
  end
  match '/login', to: 'sessions#new', via: :get, :as => 'login'
  match '/login/create', to: 'sessions#create', via: :post, :as => 'sessions'
  match '/about', to: 'pages#about', via: :get, :as => 'about'
  match '/logout', to: 'sessions#destroy', via: :delete, :as => 'logout'
  get 'data/audio/:filename', to: 'sounds#audio', as: 'audio'
end
