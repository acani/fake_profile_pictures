require 'spec_helper'

module FakeProfilePictures
  describe License do
    let(:license4) { License.new("4") }
    let(:license5) { License.new("5") }

    describe "#abbr" do
      context "@code = 4" do
        specify { license4.abbr.should eq("by") }
      end

      context "@code = 5" do
        specify { license5.abbr.should eq("by-sa") }
      end
    end

    describe "#to_s" do
      context "@code = 4" do
        specify { license4.to_s.should eq("Attribution") }
      end

      context "@code = 5" do
        specify { license5.to_s.should eq("Attribution-ShareAlike") }
      end
    end
    
    describe "#long" do
      context "@code = 4" do
        specify { license4.long.should eq("Creative Commons - #{license4.to_s} 2.0 Generic") }
      end

      context "@code = 5" do
        specify { license5.long.should eq("Creative Commons - #{license5.to_s} 2.0 Generic") }
      end
    end
  end
end
