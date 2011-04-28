require 'net/http' # to download photo info
require 'json'     # to parse Flickr's JSON response

module FakeProfilePictures
  class Photo
    DIR = File.expand_path(File.join(File.dirname(__FILE__), "photos"))
    GIT_DIR = "https://github.com/acani/fake_profile_pictures/raw/master/lib/fake_profile_pictures/photos"

    NORTH_GRAVITY_IDS = [
      "5174950991",
      "3788426000",
      "4452457288",
      "3244887018",
      "2369151434",
      "4994965909",
      "4897110371",
      "4476799140",
      "4476798352",
      "3942969773",
      "3377864339",
      "3156504080"
    ]

    attr_reader :flickr_id, :format
    attr_accessor :license, :owner, :page_url, :title

    def initialize(filename)
      @flickr_id = filename[/_(\d+)/, 1]
      @format = filename[/\.(.*)$/, 1]
    end

    def self.all
      @@all ||= all_large_names_2x.map { |n| Photo.new(n) }
    end

    def self.all_large_names_2x
      @@all_large_names_2x ||= Dir.chdir(DIR) { Dir["large_*@2x.*"] }
    end

    def self.count
      @@count ||= all.count
    end

    def self.foreach_getInfo_with_index
      all.each_with_index do |p, i|
        begin
          p.getInfo
        rescue RuntimeError => e
          puts e.inspect
          next
        end
        yield(p, i) if block_given?
      end      
    end

    def ==(other)
      flickr_id == other.flickr_id
    end

    def large2x_name
      @large2x_name ||= "large_#{flickr_id}@2x.#{format}"
    end

    def large_name
      @large_name ||= "large_#{flickr_id}.#{format}"
    end

    def square2x_name
      @square2x_name ||= "square_#{flickr_id}@2x.#{format}"
    end

    def square_name
      @square_name ||= "square_#{flickr_id}.#{format}"
    end

    def large2x_path
      @large2x_path ||= File.join(DIR, large2x_name)
    end

    def large_path
      @large_path ||= File.join(DIR, large_name)
    end

    def square2x_path
      @square2x_path ||= File.join(DIR, square2x_name)
    end

    def square_path
      @square_path ||= File.join(DIR, square_name)
    end

    def large2x_file
      File.new(large2x_path)      
    end

    def large_file
      File.new(large_path)      
    end

    def square2x_file
      File.new(square2x_path)      
    end

    def square_file
      File.new(square_path)      
    end

    # TODO: Spec this mehtod.
    def getInfo
      uri = "#{FLICKR_URL}/services/rest/?method=flickr.photos.getInfo&photo_id=#{flickr_id}&format=json&api_key=#{FLICKR_API_KEY}"
      begin
        response = Net::HTTP.get_response(URI.parse(uri)).body.to_s
      rescue SocketError => e
        puts "Error! Couldn't connect to Flickr to download photo info."
        puts
        raise e
      end
      meta = JSON.parse(response[14..-2]) # strip JSONP padding
      unless meta["stat"] == "ok"
        raise "Flickr error: photo_id: #{flickr_id}: error: #{meta["code"]} - #{meta["message"]}."
      end
      photo = meta["photo"]
      
      self.license = License.new(photo["license"])
      self.owner = Person.new({
        nsid: photo["owner"]["nsid"],
        username: photo["owner"]["username"],
        realname: photo["owner"]["realname"]
      })
      self.page_url = photo["urls"]["url"][0]["_content"]
      self.title = photo["title"]["_content"]
      self # returns self
    end

    def gravity
      @gravity ||= NORTH_GRAVITY_IDS.include?(flickr_id) ?
          Magick::NorthGravity : Magick::CenterGravity
    end
    
    def about
      return @about unless @about.nil?
      getInfo if title.nil?
      @about = "The overlaid textual info about the person in this photo and its thumbnail was fabricated and, thus, is very unlikely to be true. This photo and its thumbnail are cropped and/or resized derivatives of \"#{title}\" by #{owner.realname} (#{owner.username}) on Flickr. License: #{license.long}. Accessed 28 Apr. 2011. #{page_url}"
    end
  end
end
