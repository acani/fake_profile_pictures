require 'spec_helper'

module FakeProfilePictures
  describe Person do
    let(:person) do
      Person.new({
        nsid: "36673942@N08",
        username: "mattdipasquale",
        realname: "Matt Di Pasquale"
      })
    end

    it "has the expected attributes" do
      person.should respond_to(
        :nsid,
        :username,
        :realname,
      )
    end

    describe "#new" do
      specify { person.nsid.should eq("36673942@N08") }
      specify { person.username.should eq("mattdipasquale") }
      specify { person.realname.should eq("Matt Di Pasquale") }
    end
  end
end
