Rails.application.routes.draw do
  
  namespace :admin do
    root to: "homes#top"
    resources :users
    resources :posts, only: [:destroy]
  end
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }
  
  get 'homes/top'
  
  root to: 'homes#top'
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

  devise_for :users , controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    resources :post_images, only: [:new, :create, :index, :show, :destroy]
    #resources :users, only: [:new,:show, :edit]
  end
  
  namespace :public do
    get '/users/unsubscribe' => 'users#unsubscribe',as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw',as: 'withdraw'
    resources :users, only: [:new, :show, :edit, :update]
    resources :posts, only: [:new, :show, :index, :create]
    resources :comments, only: [:show, :create, :destroy]
    resources :favorites, only: [:destroy]
    post 'favorites/:id' => 'favorites#create',as: 'favorites'
    resources :tags, only: [:show]
  end
  
end
