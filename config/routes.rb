Rails.application.routes.draw do
  get 'appointments/index'
  get 'appointments/new'
  root 'users#index'

  resources :users
  resources :physicians do
    resources :appointments, only: [:index, :new, :create, :destroy]
  end
end