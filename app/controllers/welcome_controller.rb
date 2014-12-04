class WelcomeController < ApplicationController
  
  def user_profile
    if user_signed_in? == false
      redirect_to root_url      
    end
  end
end
