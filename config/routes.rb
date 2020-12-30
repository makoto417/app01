Rails.application.routes.draw do
  root 'top#index'
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  post '/top/guest_sign_in', to: 'top#new_guest'
  resources :users, only: [:index, :show] do
    collection do
      get :setting
      get :nickname
      get :profileimage
      get :profile
      get :gameprofile
      get :email
    end
    member do
      get :followed, :followers, :recommend
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:index, :create, :show]
  resources :direct_messages, only: [:create, :destroy]
  resources :boards do
    resources :comments, only: [:create, :destroy] 
  end
  resources :posts, only: [:new, :create]
end
