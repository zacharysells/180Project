class PaymentController < ApplicationController
  
  def set_default_payment_info
    @user = current_user
    @payment_info = @user.paymentinfo.create(:first_name => params[:first_name],
                                              :last_name => params[:last_name],
                                              :address1 => params[:add1],
                                              :address2 => params[:add2],
                                              :city => params[:city],
                                              :state => params[:state],
                                              :country => params[:country],
                                              :ccn => params[:ccn],
                                              :cvs => params[:cvs],
                                              :expiration_date => params[:expdate]
                                              )
    redirect_to 'welcome/user_profile'
  end
  
end
