Rails.application.routes.draw do
  

  devise_for :users
  get 'welcome/index'
  post 'welcome/index'
  
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

  root 'welcome#index'
  
  resource :user do
    resources :reservations
  end

  
end
