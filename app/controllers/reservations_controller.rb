require 'rubygems'
require 'active_merchant'

require 'Hotel'
require 'Destination'

class ReservationsController < ApplicationController

  before_action :authenticate_user!

  $id
  $name
  $city
  $price
  $rate
  $arrival
  $departure

  $cc_errors
  $cc_default

  def create
    @user = current_user
    @reservation = @user.reservations.create(:hotel_id => $id,
                                             :hotel_name => $name,
                                             :arrival_date => $arrival,
                                             :departure_date => $departure,
                                             :rate => $rate
                                            )
    redirect_to '/reservations/reservationSummary'
  end

  def modify
    redirect_to '/reservations/modifyreservations'
  end

  def update
    @reservation = current_user.reservations.find(params[:id])
    @reservation.arrival_date = Date.new(params[:arrival_date][:year].to_i, params[:arrival_date][:month].to_i, params[:arrival_date][:day].to_i)
    @reservation.departure_date = Date.new(params[:departure_date][:year].to_i, params[:departure_date][:month].to_i, params[:departure_date][:day].to_i)

    if @reservation.save
      redirect_to '/welcome/user_profile'
    else
      redirect_to reservations_modifyreservation_path(:id => params[:id])
    end
  end

  def delete
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    redirect_to '/welcome/user_profile'
  end

  def index
    $id        = params[:hotelId]
    $name      = params[:name]
    $city      = params[:city]
    $arrival   = Date.new(params[:arrivalDate][:year].to_i, params[:arrivalDate][:month].to_i, params[:arrivalDate][:day].to_i)
    $departure = Date.new(params[:departureDate][:year].to_i, params[:departureDate][:month].to_i, params[:departureDate][:day].to_i)
    $price     = (params[:price].to_i * ($departure - $arrival)).to_i
    $rate = params[:price]
    $cc_errors = false
    $cc_default = false
    redirect_to '/reservations/payment'
  end

  def fill_default_info
    $cc_default = true
    redirect_to '/reservations/payment'
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
