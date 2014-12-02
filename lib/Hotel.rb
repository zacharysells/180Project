$gHotelId = "hotelId"
$gHotelName = "name"
$gHotelShortDescription = "shortDescription"
$gHotelCity = "city"
$gHotelState = "stateProvinceCode"
$gHotelLatitude = "latitude"
$gHotelLongitude = "longitude"
$gHotelRating = "hotelRating"

$gHotelHighRate = "highRate"
$gHotelLowRate = "lowRate"

$gHotelAmenityMask = "amenityMask"

$gHotelThumbnail = "thumbNailUrl"

class Hotel

	attr_accessor :hotelId
	attr_accessor :name
	attr_accessor :city
	attr_accessor :stateProvinceCode
	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :shortDescription
	attr_accessor :longDescription
	attr_accessor :hotelRating
	attr_accessor :hotelPrice
	attr_accessor :amenityMask
	attr_accessor :hotelAmenities
	attr_accessor :hotelPictures
	attr_accessor :thumbNailUrl

	def initialize(hotelSummary)

		#Information about hotel

		@hotelId = hotelSummary[$gHotelId]
		@name = hotelSummary[$gHotelName]
		@city = hotelSummary[$gHotelCity]
		@stateProvinceCode = hotelSummary[$gHotelState]
		@latitude = hotelSummary[$gHotelLatitude]
		@longitude = hotelSummary[$gHotelLongitude]
		@shortDescription = hotelSummary[$gHotelShortDescription]
		@hotelRating = hotelSummary[$gHotelRating]
		@hotelPrice = hotelSummary[$gHotelHighRate]
		@amenityMask = hotelSummary[$gHotelAmenityMask]
		if (hotelSummary[$gHotelThumbnail])
			@thumbNailUrl = "http://images.travelnow.com" + hotelSummary[$gHotelThumbnail]

		else
			@thumbNailUrl = ""

		end

	end
end
