require 'Hotel'
require 'Destination'

$gAPI_url = "http://dev.api.ean.com/ean-services/rs/hotel/v3"
$gCid = "55505"
$gApiKey = "vbcytyyspe2t9c64rv5vxmep"
$gNumberOfResults = "20"

#$gGoogleMapAPIURL = "https://www.google.com/maps/embed/v1"
#$gGoogleMapAPIKey = "AIzaSyBM18RM2LnqNgLTDC7AMBuSbkHyPI1EgfE"

$gERROR_CATEGORY_RESULT_NULL = "RESULT_NULL"
$gERROR_CATEGORY_DATA_VALIDATION = "DATA_VALIDATION"

class DatabaseController < ApplicationController

  def getHotelInfo()

	hotelId = params[:hotelId]
	@arrivalDate = params[:arrivalDate]
	@departureDate = params[:departureDate]

	#construct http request
	request = $gAPI_url + "/info?" \
			+ "cid=" + $gCid \
			+ "&apiKey=" + $gApiKey \
			+ "&hotelId=" + hotelId \
			+ "&options=" + "HOTEL_DETAILS,HOTEL_SUMMARY,PROPERTY_AMENITIES,HOTEL_IMAGES"

	response = JSON.parse(HTTParty.get(request).body)

	if response["HotelInformationResponse"]["EanWsError"] then
		hotelError = response["HotelInformationResponse"]["EanWsError"]

		     #No results were returned
		     if hotelError["category"] == $gERROR_CATEGORY_RESULT_NULL then

				 #TODO: Figure out what to do if no results were found.
		         #	     Currently sending them to error page
			     redirect_to '/database/errorPage'

		     else
				 redirect_to '/database/errorPage'
		     end

	#We got a valid response. Parse the response and create a detailed hotel Object
	else
		#Fill out hotel object with Hotel Summary
		@hotel = Hotel.new(response["HotelInformationResponse"]["HotelSummary"])

		#Fill out hotel object with Hotel Details(Long Description)
		@hotel.longDescription = response["HotelInformationResponse"]["HotelDetails"]["propertyDescription"]

		#Fill out hotel object with Hotel Amenities
		hotelAmenitiesList = []
		hotelAmenitiesListSize = Integer(response["HotelInformationResponse"]["PropertyAmenities"]["@size"])

		(0..(hotelAmenitiesListSize - 1)).each do |i|
			hotelAmenity = response["HotelInformationResponse"]["PropertyAmenities"]["PropertyAmenity"][i]["amenity"]
			hotelAmenitiesList << hotelAmenity
		end
		@hotel.hotelAmenities = hotelAmenitiesList

		#Fill out hotel object with Hotel Pictures
		hotelPicturesList = []
		hotelPicturesListSize = Integer(response["HotelInformationResponse"]["HotelImages"]["@size"])

		(0..(hotelPicturesListSize - 1)).each do |i|
			hotelPicture = response["HotelInformationResponse"]["HotelImages"]["HotelImage"][i]["url"]
			hotelPicturesList << hotelPicture
		end
		@hotel.hotelPictures = hotelPicturesList

    #@mapURL = $gGoogleMapAPIURL + "/search?" \
        #+ "key=" + $gGoogleMapAPIKey \
        #+ "&q=" + (@hotel.latitude).to_s + "," + (@hotel.longitude).to_s

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
  @sort = ['PRICE', 'QUALITY', 'PROXIMITY'].find{|s| s == params[:sort]}
  @sort ||= 'CITY_VALUE' #sort by default
	@destinationString = params[:poi].gsub(' ', '+')
	@propertyName = params[:name].gsub(' ', '+')
	@stateProvinceCode = params[:state].gsub(' ', '+')
	@city = params[:city].gsub(' ', '+')

	arrival =  DateFormat(params[:arrival])
	departure = DateFormat(params[:departure])

	@arrivalDate = params[:arrival]
	@departureDate = params[:departure]

	@priceRange = params[:priceRange]
	@starRange = params[:starRange]

	minStarRating = @starRange.split(',')[0]
	maxStarRating = @starRange.split(',')[1]

	minRate = @priceRange.split(',')[0]
	maxRate = @priceRange.split(',')[1]

  amenities = params[:amenities]


	#construct http request
	request = $gAPI_url + "/list?" \
			+ "cid=" + $gCid \
			+ "&apiKey=" + $gApiKey \
			+ "&numberOfResults=" + $gNumberOfResults \
      + "&sort=" + @sort \
			+ "&destinationString=" + @destinationString \
			+ "&propertyName=" + @propertyName \
			+ "&stateProvinceCode=" + @stateProvinceCode \
			+ "&city=" + @city \
			+ "&minStarRating=" + minStarRating \
			+ "&maxStarRating=" + maxStarRating \
			+ "&minRate=" + minRate \
			+ "&maxRate=" + maxRate \
			+ "&arrivalDate=" + arrival \
			+ "&departureDate=" + departure


	response = JSON.parse(HTTParty.get(request).body)["HotelListResponse"]
  @hotelList = []
  puts request

	# Check for EanWsError
	if response["EanWsError"] then
		hotelError = response["EanWsError"]

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

			redirect_to '/database/errorPage'
      return

		#No results were returned
		elsif hotelError["category"] == $gERROR_CATEGORY_RESULT_NULL then
			#TODO: Figure out what to do if no results were found.
			#	   Currently sending them to error page
			redirect_to '/database/errorPage'
      return

		else
			#TODO: Figure out what to do if no results were found.
			#	   Currently sending them to error page
			redirect_to '/database/errorPage'
      return

		end

	#We got a valid response. Parse the response and create a list of hotel objects.
	else

    # Create amenity mask to filter hotels.
    if amenities == nil
      amenitiesMask = 0
    else
      amenitiesMask = 0
      amenities.each do |amenity|
        amenitiesMask = amenitiesMask | amenity.to_i
      end
    end

    @hotelListSize = Integer(response["HotelList"]["@size"])
    # Special case for hotel list of size 1.
		if (@hotelListSize == 1)
			hotelSummary = response['HotelList']['HotelSummary']
      if (hotelSummary["amenityMask"].to_i & amenitiesMask == amenitiesMask)
        @hotelList << Hotel.new(hotelSummary)
      end
		else
			response['HotelList']['HotelSummary'].each do |hotelSummary|
        # If hotel has amenity in filter, add it to hotel list.
        if (hotelSummary["amenityMask"].to_i & amenitiesMask == amenitiesMask)
  			  @hotelList << Hotel.new(hotelSummary)
        end
			end
      if @sort == "PRICE" then
        @hotelList.sort! { |a,b| a.hotelPrice <=> b.hotelPrice}

      elsif @sort == "QUALITY" then
        @hotelList.sort! { |a,b| b.hotelRating <=> a.hotelRating}

      end
		end

	  end
    # If no hotels pass through the filter, redirect to error page.
    if @hotelList.size == 0
      redirect_to '/database/errorPage'
      return
    end
  end
end
