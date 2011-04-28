$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "lib"))
require 'fake_profile_pictures'

module FakeProfilePictures
  desc "Generate the README.md file by downloading Flickr photo info."
  task :readme do
    generate_readme
  end

  desc "Rename photo filenames. (Commented out for safety.)"
  task :rename do
    # Photo.all.each do |p|
    #   old_path = File.join(Photo::DIR, p.large2x_name)
    #   new_path = File.join(Photo::DIR, "large_#{p.flickr_id}@2x.jpg")
    #   system("mv #{old_path} #{new_path}")
    # 
    #   old_path = File.join(Photo::DIR, p.large_name)
    #   new_path = File.join(Photo::DIR, "large_#{real_flickr_id}.jpg")
    #   system("mv #{old_path} #{new_path}")
    # 
    #   old_path = File.join(Photo::DIR, p.square2x_name)
    #   new_path = File.join(Photo::DIR, "square_#{real_flickr_id}@2x.jpg")
    #   system("mv #{old_path} #{new_path}")
    # 
    #   old_path = File.join(Photo::DIR, p.square_name)
    #   new_path = File.join(Photo::DIR, "square_#{real_flickr_id}.jpg")
    #   system("mv #{old_path} #{new_path}")
    # end
  end

  desc "Resize 'picture_.*@2x.*' to 320x480, 150x150, and 75x75 pixels."
  task :resize do
    begin
      require 'RMagick'
    rescue LoadError => e
      puts "\nError! ImageMagick is required by this task.\n\n"
      raise e
    end
    puts
    puts "Creating 320x480, 150x150, and 75x75 pixel images for each photo in:"
    puts Photo::DIR
    puts
    puts "Total: #{Photo.count}"
    Photo.all.each do |p|
      puts "#{p.flickr_id}"
      pi2 = Magick::Image::read(p.large2x_name).first
      pi2.resize(320, 480).write(p.large_name)
      thb2 = pi2.resize_to_fill(150, 150, p.gravity).write(p.square2x_name)
      thb = pi2.resize_to_fill(75, 75, gravity).write(p.square_name)
    end
    puts
    puts "Done!"
    puts
    sleep 0.3
    system "open ."
  end
end