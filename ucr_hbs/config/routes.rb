Rails.application.routes.draw do
  
  as :user do
    #get "welcome/user_profile" => "devise/sessions#new"
  end

  devise_for :users
  get 'welcome/index'
  post 'welcome/index'
  
  get 'welcome/user_profile', to: 'welcome#user_profile'
  
  get 'database/getList', to: 'database#getList'
  post 'database/getList'
  

  get 'database/hotelInfo'
  post 'database/getHotelInfo'

  get 'database/altList'
  
  get 'database/reserve'
  post 'database/reserve'
  
  
  get'reservations/confirmation', to: 'reservations#confirmation'
  post'reservations/confirmation'
  
  get 'reservations/payment', to: 'reservations#payment'
  post 'reservations/payment'
  
  post 'reservations/validate_credit_card'
  
  resources :reviews
  post 'reviews/new'

  root 'welcome#index'
  
  resource :user do
    resources :reservations
  end

  
end
