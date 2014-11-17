class WelcomeController < ApplicationController
  def index
    StoreSearchParams(params)
  end
end
