class ReviewsController < ApplicationController
  
  $hotel_id
  
  def new
    $hotel_id = params[:hotel_id]
  end
  
  def create
    @user = current_user
    @review = @user.reviews.create(:hotel_id => $hotel_id,
                         :stars => params[:review][:stars],
                         :body => params[:review][:body],
                         :review_date => DateTime.now
                        )
    redirect_to '/welcome/user_profile'
  end
  
end
