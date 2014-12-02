
class AmenityMask
  attr_accessor :amenityName
  attr_accessor :bitMask


  def initialize(mask, name)

    @bitMask = mask
    @amenityName = name


  end

end
