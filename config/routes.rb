Rails.application.routes.draw do

  as :user do
    #get "welcome/user_profile" => "devise/sessions#new"
  end
  root :to => 'welcome#index'
  get "welcome/index", :to => "welcome#index", :as => 'welcome_index'

  devise_for :users
  get 'welcome/index'
  post 'welcome/index'

  get 'welcome/user_profile', to: 'welcome#user_profile'

  get 'database/getList', to: 'database#getList'
  post 'database/getList'

  get 'database/hotelInfo'
  post 'database/getHotelInfo'

  get 'database/altList'

  get 'database/errorPage'

  get 'database/reserve'
  post 'database/reserve'


  get'reservations/confirmation', to: 'reservations#confirmation'
  post'reservations/confirmation'

  get 'reservations/reservationSummary'

  get 'reservations/payment', to: 'reservations#payment'
  post 'reservations/payment'

  post 'reservations/validate_credit_card'

  resources :reviews
  post 'reviews/new'

  post 'reservations/index'


  resource :user do
    resources :reservations
  end


end
