module FakeProfilePictures
  class License    
    def initialize(code)
      raise "License #{code} is too restrictive!" if !%w[4 5].include? code
      @code = code
    end

    def abbr
      @abbr ||= case @code
      when "4" then "by"
      when "5" then "by-sa"
      end
    end

    def to_s
      @s ||= case @code
      when "4" then "Attribution"
      when "5" then "Attribution-ShareAlike"
      end
    end

    def long
      @long ||= "Creative Commons - #{self} 2.0 Generic"
    end
  end
end
