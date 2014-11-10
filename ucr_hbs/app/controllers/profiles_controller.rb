class ProfilesController < ApplicationController
	def index
	
	end
	
	def show
	
	end
	
	def edit
	   @profile = Profile.find_by user_id: current_user.id
	   @attributes = Profile.attribute_names - %w(id user_id created_at updated_at)
	end
end
