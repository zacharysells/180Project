require 'rubygems'
require 'active_merchant'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def StoreSearchParams(params)
    @search_params = params
  end
  
  @payment_verified = false
  
  helper_method :Validate_Credit_Card
  
  def Validate_Credit_Card
    return true
  end
  
  
  
end
