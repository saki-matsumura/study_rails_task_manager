Rails.application.routes.draw do
  # get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tasks#index"
  resources :tasks
  resources :users, only: [:new, :create, :edit, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
