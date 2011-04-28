require 'spec_helper'

module FakeProfilePictures
  describe Photo do
    let(:photo1) { Photo.new("large_5174950991@2x.jpg").getInfo }
    let(:photo2) { Photo.new("square_4530910556@2x.png") }

    describe "DIR" do
      specify do
        Photo::DIR.should eq(File.expand_path(File.join(File.dirname(__FILE__),
            "..", "..", "lib", "fake_profile_pictures", "photos")))
      end
    end

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
      specify { Photo.all.should have(26).photos }
    end

    describe "::all_large_names_2x" do
      specify { Photo.all_large_names_2x.first.should eq("large_2369151434@2x.jpg") }
      specify { Photo.all_large_names_2x.should have(26).photos }
    end

    describe "::count" do
      specify { Photo.count.should equal(26) }
    end

    describe "#==" do
      specify { photo1.should eq(Photo.new("large_5174950991.jpg")) }
    end

    describe "#large2x_name" do
      context "format: jpg" do
        specify { photo1.large2x_name.should eq("large_5174950991@2x.jpg") }
      end

      context "format: png" do
        specify { photo2.large2x_name.should eq("large_4530910556@2x.png") }
      end
    end

    describe "#large_name" do
      context "format: jpg" do
        specify { photo1.large_name.should eq("large_5174950991.jpg") }
      end

      context "format: png" do
        specify { photo2.large_name.should eq("large_4530910556.png") }
      end
    end

    describe "#square2x_name" do
      context "format: jpg" do
        specify { photo1.square2x_name.should eq("square_5174950991@2x.jpg") }
      end

      context "format: png" do
        specify { photo2.square2x_name.should eq("square_4530910556@2x.png") }
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

    describe "#large2x_path" do
      specify { photo1.large2x_path.should eq(File.join(Photo::DIR, photo1.large2x_name)) }
    end

    describe "#large_path" do
      specify { photo1.large_path.should eq(File.join(Photo::DIR, photo1.large_name)) }
    end

    describe "#square2x_path" do
      specify { photo1.square2x_path.should eq(File.join(Photo::DIR, photo1.square2x_name)) }
    end

    describe "#square_path" do
      specify { photo1.square_path.should eq(File.join(Photo::DIR, photo1.square_name)) }
    end

    describe "#large2x_file" do
      specify { File.basename(photo1.large2x_file).should eq(photo1.large2x_name) }
    end

    describe "#large_file" do
      specify { File.basename(photo1.large_file).should eq(photo1.large_name) }
    end

    describe "#square2x_file" do
      specify { File.basename(photo1.square2x_file).should eq(photo1.square2x_name) }
    end

    describe "#square_file" do
      specify { File.basename(photo1.square_file).should eq(photo1.square_name) }
    end

    describe "#gravity" do
      context "Magick::NorthGravity" do
        specify { photo1.gravity.should equal(Magick::NorthGravity) }
      end

      context "Magick::CenterGravity" do
        specify { photo2.gravity.should equal(Magick::CenterGravity) }
      end
    end
    
    describe "#about" do
      specify { photo1.about.should eq("The overlaid textual info about the person in this photo and its thumbnail was fabricated and, thus, is very unlikely to be true. This photo and its thumbnail are cropped and/or resized derivatives of \"#{photo1.title}\" by #{photo1.owner.realname} (#{photo1.owner.username}) on Flickr. License: #{photo1.license.long}. Accessed 28 Apr. 2011. #{photo1.page_url}") }
    end
  end
end
