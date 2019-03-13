Rails.application.routes.draw do
  root to: 'tasks#index'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end

  resources :tasks
  resources :relationships, only: [:create, :destroy]
  
end