class ReviewsController < ApplicationController
	def index
		@reviews = Review.all
	end
	
	
	
	def view
	end
	
	def create
		@review = Review.new(review_params)
 
  	@review.save
  	redirect_to @review
	end
	
	def show
		@review = Review.find(params[:id])
	end
	
	private
  	def review_params
    	params.require(:review).permit(:hotel, :rating, :text)
  	end
end
