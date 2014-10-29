$gHotelId = "hotelId"
$gHotelShortDescription = "shortDescription"
$gHotelCity = "city"
$gHotelState = "stateProvinceCode"

class Hotel
	attr_accessor :hotelId
	attr_accessor :city
	attr_accessor :stateProvinceCode
	attr_accessor :shortDescription
	attr_accessor :url #change name convention
	#add more hotel attributes as desired
	
	
	def initialize(hotelInfo)
		
		#Array of Information about hotel
		hotelSummary = hotelInfo["HotelListResponse"]["HotelList"]["HotelSummary"]
		hotelImage = hotelInfo["HotelListResponse"]["HotelList"]["HotelImage"]
		
		@hotelId = hotelSummary[$gHotelId]
		@city = hotelSummary[$gHotelCity]
		@stateProvinceCode = hotelSummary[$gHotelState]
		@shortDescription = hotelSummary[$gHotelShortDescription]
		@url = hotelImage[0]["url"]
	
	end


end
