Rails.application.routes.draw do
  root to: 'tasklist#index'

  resources :tasklist
end