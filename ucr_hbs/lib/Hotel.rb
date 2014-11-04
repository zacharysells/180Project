$gHotelId = "hotelId"
$gHotelName = "name"
$gHotelShortDescription = "shortDescription"
$gHotelCity = "city"
$gHotelState = "stateProvinceCode"
$gHotelRating = "hotelRating"
$gHotelHighRate = "highRate"
$gHotelLowRate = "lowRate"

class Hotel
	attr_accessor :hotelId
	attr_accessor :name
	attr_accessor :city
	attr_accessor :stateProvinceCode
	attr_accessor :shortDescription
	attr_accessor :hotelRating
	attr_accessor :highRate
	attr_accessor :lowRate
	#add more hotel attributes as desired
	
	
	def initialize(hotelSummary)
		
		#Array of Information about hotel
		
		@hotelId = hotelSummary[$gHotelId]
		@name = hotelSummary[$gHotelName]
		@city = hotelSummary[$gHotelCity]
		@stateProvinceCode = hotelSummary[$gHotelState]
		@shortDescription = hotelSummary[$gHotelShortDescription]
		@hotelRating = hotelSummary[$gHotelRating]
		@highRate = hotelSummary[$gHotelHighRate]
		@lowRate = hotelSummary[$gHotelLowRate]
	
	end


end
