require 'spec_helper'

module FakeProfilePictures
  describe Photo do
    let(:photo1) { Photo.new("large_5174950991@2x.jpg") }
    let(:photo2) { Photo.new("square_4530910556@2x.png") }

    specify do
      photo1.should respond_to(
        :flickr_id,
        :format,
        :license, :license=,
        :owner, :owner=,
        :page_url, :page_url=,
        :title, :title=
      )
    end

    describe "::all" do
      specify { Photo.all_large_names_2x.first.should eq("large_2369151434@2x.jpg") }
      specify { Photo.all.should have(28).photos }
    end

    describe "::all_large_names_2x" do
      specify { Photo.all_large_names_2x.first.should eq("large_2369151434@2x.jpg") }
      specify { Photo.all_large_names_2x.should have(28).photos }
    end

    describe "::count" do
      specify { Photo.count.should equal(28) }
    end

    describe "#==" do
      specify { photo1.should eq(Photo.new("large_5174950991.jpg")) }
    end

    describe "#large_name" do
      context "format: jpg" do
        specify { photo1.large_name.should eq("large_5174950991.jpg") }
      end

      context "format: png" do
        specify { photo2.large_name.should eq("large_4530910556.png") }
      end
    end
    
    describe "#large_name_2x" do
      context "format: jpg" do
        specify { photo1.large_name_2x.should eq("large_5174950991@2x.jpg") }
      end

      context "format: png" do
        specify { photo2.large_name_2x.should eq("large_4530910556@2x.png") }
      end
    end

    describe "#square_name" do
      context "format: jpg" do
        specify { photo1.square_name.should eq("square_5174950991.jpg") }
      end

      context "format: png" do
        specify { photo2.square_name.should eq("square_4530910556.png") }
      end
    end

    describe "#square_name_2x" do
      context "format: jpg" do
        specify { photo1.square_name_2x.should eq("square_5174950991@2x.jpg") }
      end

      context "format: png" do
        specify { photo2.square_name_2x.should eq("square_4530910556@2x.png") }
      end
    end

    describe "#gravity" do
      context "Magick::NorthGravity" do
        specify { photo1.gravity.should equal(Magick::NorthGravity) }
      end

      context "Magick::CenterGravity" do
        specify { photo2.gravity.should equal(Magick::CenterGravity) }
      end
    end
  end
end
