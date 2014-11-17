
require 'Hotel'
require 'Destination'
class DatabaseController < ApplicationController	
  
  # Input: Date Hash
  # Output: Formatted Date String MM/DD/YYYY
  def DateFormat(date)
    @newDate = date[:month] + "/" + date[:day] + "/" + date[:year]
    return @newDate
  end				
  
  def getList()
	  #search parameters
	  cid = "55505"
	  apiKey = "vbcytyyspe2t9c64rv5vxmep"
	  destinationString = params[:city].gsub(' ', '+')
	  #city = "Seattle"
	  stateProvinceCode = "CA"
	  #countryCode = "US"
	  arrivalDate =  DateFormat(params[:start_date])
	  departureDate = DateFormat(params[:departure])
	  numberOfResults = "7"
	
	  #construct http request
	  request = "http://dev.api.ean.com/ean-services/rs/hotel/v3/list?" \
			+ "cid=" + cid \
			+ "&apiKey=" + apiKey \
			+ "&destinationString=" + destinationString \
			+ "&arrivalDate=" + arrivalDate \
			+ "&departureDate=" + departureDate \
			+ "&numberOfResults=" + numberOfResults \
			#+ "&city=" + city \
			#+ "&stateProvinceCode=" + stateProvinceCode \
			#+ "&countryCode=" + countryCode \
			
	
	
	
	    #make http request
	    response = JSON.parse(HTTParty.get(request).body)
	
	
	    # Check for EanWsError
	    if response["HotelListResponse"]["EanWsError"] then
		    @hotelError = response["HotelListResponse"]["EanWsError"]
		
		    if @hotelError["category"] = "DATA_VALIDATION" then
			#create list of suggested destinations
			@destinationList = []
			@destinationListSize = Integer(response["HotelListResponse"]["LocationInfos"]["@size"]) -1 
			
			(0..(@destinationListSize)).each do |i|
				destinationInfo = response["HotelListResponse"]["LocationInfos"]["LocationInfo"][i]
				@destinationList << Destination.new(destinationInfo)
			end
				
			#redirect_to '/database/altList'
		end
	
	
	#We got a valid response. Parse the response and create a list of hotel objects
	else 
	
		#Our hotelListSize is subtracted by 1 because we only want up to last index
		#and the 0 position is included in the size
		#and ruby is being dumb and wont let me subtract it in the loop below
		
		@hotelList = []
		@hotelListSize = Integer(response["HotelListResponse"]["HotelList"]["@size"]) -1 
					
		(0..(@hotelListSize)).each do |i|
			hotelSummary = response["HotelListResponse"]["HotelList"]["HotelSummary"][i]
			@hotelList << Hotel.new(hotelSummary)
		end
		
	end
  end
end
