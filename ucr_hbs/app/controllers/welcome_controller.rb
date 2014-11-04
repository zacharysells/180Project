class WelcomeController < ApplicationController
  def index
    StoreSearchParams(params)
    #@search_name = params[:name]
    #@name = @search_name
  end
end
