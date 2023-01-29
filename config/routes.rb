Rails.application.routes.draw do
  get 'homes/top'
  
  #root to: 'homes#index'
  root to: 'homes#top'
   post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  devise_for :users , controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
end
