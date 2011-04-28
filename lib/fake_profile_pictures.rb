begin
  require 'rmagick'
rescue LoadError
  module Magick
    NorthGravity = 1  # arbitrary; actual value is probably different.
    CenterGravity = 0 # arbitrary; actual value is probably different.
  end
end

FLICKR_URL = 'http://www.flickr.com'
FLICKR_API_KEY = "your_api_key"

require 'fake_profile_pictures/license'
require 'fake_profile_pictures/person'
require 'fake_profile_pictures/photo'
