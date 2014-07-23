Rails.application.routes.draw do
  resources :posts
  root to: 'posts#index'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'profile', to: 'users#show', as: 'profile'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets

end
