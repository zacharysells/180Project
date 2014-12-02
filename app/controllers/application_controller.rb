require 'rubygems'
require 'active_merchant'
require 'AmenityMask'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    "/welcome/user_profile"
  end

  def index
    @amenityMasks = [AmenityMask.new(1, "Business Center"), \
      AmenityMask.new(2, "Fitness Center"), \
      AmenityMask.new(4, "Hot Tub On-site"), \
      AmenityMask.new(8, "Internet Access Available"), \
      AmenityMask.new(16, "Kids' Activities"), \
      AmenityMask.new(32, "Kitchen or Kitchenette"), \
      AmenityMask.new(64, "Pets Allowed"), \
      AmenityMask.new(128, "Pool"), \
      AmenityMask.new(256, "Restaurant On-site"), \
      AmenityMask.new(512, "Spa On-site"), \
      AmenityMask.new(1024, "Whirlpool Bath Available"), \
      AmenityMask.new(2048, "Breakfast"), \
      AmenityMask.new(4096, "Babysitting"), \
      AmenityMask.new(8192, "Jacuzzi"), \
      AmenityMask.new(16384, "Parking"), \
      AmenityMask.new(32768, "Room Service"), \
      AmenityMask.new(65536, "Accessible Path of Travel"), \
      AmenityMask.new(131072, "Accessible Bathroom"), \
      AmenityMask.new(262144, "Roll-in Shower"), \
      AmenityMask.new(524288, "Handicapped Parking"), \
      AmenityMask.new(1048576, "In-room Accessibility"), \
      AmenityMask.new(2097152, "Accessibility Equipment for the Deaf"), \
      AmenityMask.new(4194304, "Braille or Raised Signage"), \
      AmenityMask.new(8388608, "Free Airport Shuttle"), \
      AmenityMask.new(16777216, "Indoor Pool"), \
      AmenityMask.new(33554432, "Outdoor Pool"), \
      AmenityMask.new(67108864, "Extended Parking"), \
      AmenityMask.new(134217728, "Free Parking")]
  end


end
