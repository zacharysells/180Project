require 'rubygems'
require 'active_merchant'

class ReservationsController < ApplicationController

  $name      
  $city      
  $price     
  $arrival   
  $departure  
  
  $cc_errors

  def create
    @user = current_user
    @reservation = @user.reservations.create(:hotel_id => 123,
                                             :arrival_date => Date.today,
                                             :departure_date => Date.tomorrow,
                                             :rate => 100.02
                                            )
    redirect_to root_url
  end

  def index
    $name      = params[:name]
    $city      = params[:city]
    $arrival   = Date.new(params[:arrival][:year].to_i, params[:arrival][:month].to_i, params[:arrival][:day].to_i)
    $departure = Date.new(params[:departure][:year].to_i, params[:departure][:month].to_i, params[:departure][:day].to_i) 
    $price     = (params[:price].to_i * ($departure - $arrival)).to_i
    $cc_errors = false
    redirect_to '/reservations/payment'
  end
  
  def clean_index
    $name      = params[:name]
    $city      = params[:city]
    $arrival   = Date.new(params[:arrival][:year].to_i, params[:arrival][:month].to_i, params[:arrival][:day].to_i)
    $departure = Date.new(params[:departure][:year].to_i, params[:departure][:month].to_i, params[:departure][:day].to_i) 
    $price     = (params[:price].to_i * ($departure - $arrival)).to_i
    $cc_errors = false
    redirect_to '/reservations/payment'
  end
  
  def confirmation
  end
  
  def payment
  end
  
  def validate_credit_card
    # Use the TrustCommerce test servers
    ActiveMerchant::Billing::Base.mode = :test

                
                gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
                            :login => 'TestMerchant',
                            :password => 'password')

                # ActiveMerchant accepts all amounts as Integer values in cents
                amount = 1000  # $10.00

                # The card verification value is also known as CVV2, CVC2, or CID
                credit_card = ActiveMerchant::Billing::CreditCard.new(
                                :first_name         => params[:first_name],
                                :last_name          => params[:last_name],
                                :number             => params[:ccn],
                                :month              => '8',
                                :year               => Time.now.year+1,
                                :verification_value => params[:cvs])

                # Validating the card automatically detects the card type
                if credit_card.validate.empty?
                  # Capture $10 from the credit card
                  response = gateway.purchase(amount, credit_card)

                  if response.success?
                    #puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
                    redirect_to '/reservations/confirmation'
                  else
                    #raise StandardError, response.message
                    $cc_errors = true
                    redirect_to '/reservations/payment'
                  end
                else
                  $cc_errors = true
                  redirect_to '/reservations/payment'
                end  
  end
  
end
