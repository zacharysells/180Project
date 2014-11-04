$gDestinationId = "destinationId"
$gDestinationCity = "city"
$gDestinationState = "stateProvinceCode"
$gDestinationCountry = "countryName"


class Destination
	attr_accessor :destinationId
	attr_accessor :city
	attr_accessor :stateProvinceCode
	attr_accessor :countryName
	
	def initialize(destinationInfo)
	
		@destinationId = destinationInfo[$gDestinationId]
		@city = destinationInfo[$gDestinationCity]
		@stateProvinceCode = destinationInfo[$gDestinationState]
		@countryName = destinationInfo[$gDestinationCountry]

	end
	
end
