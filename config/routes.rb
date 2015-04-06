Rails.application.routes.draw do
  root to: 'trips#index'

  get    '/register', to: 'users#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  get    '/logout',   to: 'sessions#destroy'

  resources :trips, except: [:destroy] do
    resources :posts, except: [:destroy, :index]
  end

  resources :users, only: [:show, :create, :edit, :update]
end
