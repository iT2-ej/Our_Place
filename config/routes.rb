Rails.application.routes.draw do
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }
  
  get 'homes/top'
  
  #root to: 'homes#index'
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
    resources :users, only: [:new,:show, :edit]
  end
  
end
