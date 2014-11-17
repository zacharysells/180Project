$gDestinationId = "destinationId"
$gDestinationCity = "city"
$gDestinationState = "stateProvinceCode"
$gDestinationCountry = "countryName"


class Destination
	attr_accessor :destinationId
	attr_accessor :search_url
	attr_accessor :city
	attr_accessor :stateProvinceCode
	attr_accessor :countryName
	
	def initialize(destinationInfo)
	
		@destinationId = destinationInfo[$gDestinationId]

		#Add search_url that will take them to hotel listing of selected destination(ID)
		#@search_url =

		@city = destinationInfo[$gDestinationCity]
		@stateProvinceCode = destinationInfo[$gDestinationState]
		@countryName = destinationInfo[$gDestinationCountry]

	end
	
end
