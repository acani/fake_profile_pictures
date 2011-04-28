module FakeProfilePictures
  class Person
    attr_reader :nsid, :username, :realname
    
    def initialize(options={})
      options.each_pair do |k, v|
        instance_variable_set("@#{k}".to_sym, v)
      end
    end
  end
end
