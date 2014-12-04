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

  get 'database/getHotelInfo'
  post 'database/getHotelInfo'

  get 'database/altList'

  get 'database/errorPage'

  get 'database/reserve'
  post 'database/reserve'

  post 'reservations/fill_default_info'

  get'reservations/confirmation', to: 'reservations#confirmation'
  post'reservations/confirmation'

  get 'reservations/reservationSummary'

  get 'reservations/payment' #, to: 'reservations#payment'
  post 'reservations/payment'

  post 'reservations/validate_credit_card'

  post 'reservations/modifyreservation'
  get 'reservations/modifyreservation'
  post 'reservations/update'
  post 'reservations/delete'

  resources :reviews
  post 'reviews/new'

  post 'reservations/index'

  root 'welcome#index'

  get 'welcome/payment_info'

  post 'payment_info/set_default_payment_info'

  post 'payment_info/edit'

  resource :user do
    resources :reservations
    resources :payment_info
  end


end
