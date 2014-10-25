class DatabaseController < ApplicationController					
  
  def search
	#search parameters
	cid = "55505"
	apiKey = "vbcytyyspe2t9c64rv5vxmep"
	city = "Seattle"
	stateProvinceCode = "WA"
	countryCode = "US"
	arrivalDate = "09/04/2015"
	departureDate = "09/05/2015"
	numberOfResults = "1"
	
	#construct http request
	request = "http://dev.api.ean.com/ean-services/rs/hotel/v3/list?" \
			+ "cid=" + cid \
			+ "&apiKey=" + apiKey \
			+ "&city=" + city \
			+ "&stateProvinceCode=" + stateProvinceCode \
			+ "&countryCode=" + countryCode \
			+ "&arrivalDate=" + arrivalDate \
			+ "&departureDate=" + departureDate \
			+ "&numberOfResults=" + numberOfResults
	
	
	
	#make http request
	response = HTTParty.get(request)
	@hotelList = JSON.parse(response.body)
	@hotelId = @hotelList["hotelId"]
	

	
  end
end
