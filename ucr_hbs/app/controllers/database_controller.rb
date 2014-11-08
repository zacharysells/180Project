
require 'Hotel'
require 'Destination'
		
$gAPI_url = "http://dev.api.ean.com/ean-services/rs/hotel/v3"
$gCid = "55505"
$gApiKey = "vbcytyyspe2t9c64rv5vxmep"
$gNumberOfResults = "7"


$gERROR_CATEGORY_RESULT_NULL = "RESULT_NULL"
$gERROR_CATEGORY_DATA_VALIDATION = "DATA_VALIDATION"
class DatabaseController < ApplicationController					
  
  def getHotelInfo()

	  hotelId = params[:hotelId]

	  #construct http request
	  request = $gAPI_url + "/info?" \
			      + "cid=" + $gCid \
			      + "&apiKey=" + $gApiKey \
			      + "&hotelId=" + hotelId \
			      + "&options=" + "PROPERTY_AMENITIES,HOTEL_IMAGES"

	    response = JSON.parse(HTTParty.get(request).body)


	    if response["HotelInformationResponse"]["EanWsError"] then
		      hotelError = response["HotelInformationResponse"]["EanWsError"]

		      #No results were returned
		      if hotelError["category"] == $gERROR_CATEGORY_RESULT_NULL then

			      #TODO: Figure out what to do if no results were found.
		        #	   Currently sending them back to the homepage
			      redirect_to root_url
		      end

	    #We got a valid response. Parse the response and create a list of hotel objects
	    else

		    #Our hotelAmenitiesSize is subtracted by 1 because we only want up to last index
		    #and the 0 position is included in the size
		    #and ruby is being dumb and wont let me subtract it in the loop below
		    @hotelAmenitiesList = []
		    @hotelAmenitiesSize = Integer(response["HotelInformationResponse"]["PropertyAmenities"]["@size"]) -1 

		    #(0..(@hotelListSize)).each do |i|
			  #hotelSummary = response["HotelListResponse"]["HotelList"]["HotelSummary"][i]
			  #@hotelList << Hotel.new(hotelSummary)
		    #end

		    render '/database/hotelInfo'

	    end



  end

  # Input: Date Hash
  # Output: Formatted Date String MM/DD/YYYY
  def DateFormat(date)
    @newDate = date[:month] + "/" + date[:day] + "/" + date[:year]
    return @newDate
  end

  def getList()

	#search parameters

	destinationString = params[:poi].gsub(' ', '+')
	propertyName = params[:name].gsub(' ', '+')
	stateProvinceCode = params[:state].gsub(' ', '+')
	city = params[:city].gsub(' ', '+')

	arrivalDate =  DateFormat(params[:start_date])
	departureDate = DateFormat(params[:departure])

	
	#construct http request
	request = $gAPI_url + "/list?" \
			+ "cid=" + $gCid \
			+ "&apiKey=" + $gApiKey \
			+ "&numberOfResults=" + $gNumberOfResults \
			+ "&destinationString=" + destinationString \
			+ "&propertyName=" + propertyName \
			+ "&stateProvinceCode=" + stateProvinceCode \
			+ "&city=" + city \
			+ "&arrivalDate=" + arrivalDate \
			+ "&departureDate=" + departureDate
	
  #make http request
	response = JSON.parse(HTTParty.get(request).body)
	puts request
	
	# Check for EanWsError
	if response["HotelListResponse"]["EanWsError"] then
		  hotelError = response["HotelListResponse"]["EanWsError"]
		
		  #Multiple possible destination error.
	    if hotelError["category"] == $gERROR_CATEGORY_DATA_VALIDATION then
			  #create list of suggested destinations
			

			  #We are not yet implementing the suggestions list functionality.
			  #@destinationList = []
			  #@destinationListSize = Integer(response["HotelListResponse"]["LocationInfos"]["@size"]) -1 
        
			  #(0..(@destinationListSize)).each do |i|
				#destinationInfo = response["HotelListResponse"]["LocationInfos"]["LocationInfo"][i]
				#@destinationList << Destination.new(destinationInfo)
			  #end
        
			  redirect_to '/database/altList'


		  #No results were returned
		  elsif hotelError["category"] == $gERROR_CATEGORY_RESULT_NULL then


			    #TODO: Figure out what to do if no results were found.
			    #	   Currently sending them back to the homepage
			    redirect_to root_url

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

