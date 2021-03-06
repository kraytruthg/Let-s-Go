Rails.application.routes.draw do
  root to: 'trips#index'

  get    '/register', to: 'users#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  get    '/logout',   to: 'sessions#destroy'
  get    '/tags',     to: 'tags#index'

  resources :trips, except: [:destroy] do
    resources :posts, except: [:index] do
      resources :comments, only: [:create]

      get 'star', to: 'posts#star'
      get 'like', to: 'posts#like'
    end

    get 'activities', to: 'activities#index'
  end

  resources :users, only: [:show, :create, :edit, :update]
end
