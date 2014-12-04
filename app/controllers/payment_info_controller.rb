class PaymentInfoController < ApplicationController
  
  def create
    @date_array = params[:expdate].partition("/")
    
    @user = current_user
    if @user.payment_info.blank?
    @payment_info = @user.create_payment_info(:first_name => params[:first_name],
                                              :last_name => params[:last_name],
                                              :address1 => params[:add1],
                                              :address2 => params[:add2],
                                              :city => params[:city],
                                              :state => params[:state],
                                              :country => params[:country],
                                              :ccn => params[:ccn],
                                              :cvs => params[:cvs],
                                              :expiration_date => DateTime.new(@date_array[2].to_i, @date_array[0].to_i)
                                              )
    end
    redirect_to '/welcome/user_profile'
  end
  
  def edit
    @payment_info = current_user.payment_info
    
    @payment_info.first_name = params[:first_name]
    @payment_info.last_name = params[:last_name]
    @payment_info.address1 = params[:add1]
    @payment_info.address2 = params[:add2]
    @payment_info.city = params[:city]
    @payment_info.state = params[:state]
    @payment_info.country = params[:country]
    @payment_info.ccn = params[:ccn]
    @payment_info.cvs = params[:cvs]
    
    @date_array = params[:expdate].partition("-")
    @payment_info.expiration_date = DateTime.new(@date_array[0].to_i, @date_array[2].to_i)
    
    current_user.payment_info = @payment_info
    
    redirect_to '/welcome/user_profile'
  end
  
end
