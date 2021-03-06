begin
  require 'rmagick'
rescue LoadError
  module Magick
    NorthGravity = 1  # arbitrary; actual value is probably different.
    CenterGravity = 0 # arbitrary; actual value is probably different.
  end
end

FLICKR_URL = 'http://www.flickr.com'
FLICKR_API_KEY = "44e953212fc91c5816b5abc4bb0ea375"

require 'fake_profile_pictures/license'
require 'fake_profile_pictures/person'
require 'fake_profile_pictures/photo'

module FakeProfilePictures
  class << self
    def generate_readme
      attr_doc = <<EOF
Fake Profile Pictures
=====================

Creative Commons mock user photos, safe to use for testing purposes.


Photo Credits
-------------

[Every photo in this repository][1] is a cropped and/or resized derivative of the
original. On **April 28, 2011**, all original photos were downloaded from
[Flickr][] and licensed under either the [Attribution][by] or
[Attribution-ShareAlike][by-sa] [Creative Commons license][ccl].

EOF

      link_text = <<EOF

  [1]: https://github.com/acani/fake_profile_pictures/tree/master/lib/fake_profile_pictures/photos
  [2]: http://www.flickr.com/search/?l=comm&ss=1&mt=photos&adv=1&w=all&q=pretty+portrait&m=text
  [Flickr]: #{FLICKR_URL}/
  [by]: http://creativecommons.org/licenses/by/2.0/
  [by-sa]: http://creativecommons.org/licenses/by-sa/2.0/
  [ccl]: http://creativecommons.org/licenses/

EOF
      puts
      puts "Generate the README.md file by downloading Flickr photo info."
      puts
      puts "Total: #{Photo.count}"
      puts
      Photo.foreach_getInfo_with_index do |p, i|
        f = p.flickr_id
        puts "#{j=i+1}. #{f}"
        attr_doc << <<EOF
  #{j}. ![#{p.title}][#{f}t] "[#{p.title}][#{f}p]." Photograph by [#{p.owner.realname} (#{p.owner.username}) on Flickr][#{f}o]. License: [#{p.license.long}][#{p.license.abbr}].

EOF
        link_text << <<EOF
  [#{f}t]: #{File.join(Photo::GIT_DIR, p.square_name)}
  [#{f}p]: #{p.page_url}
  [#{f}o]: #{File.join(FLICKR_URL, "people", p.owner.nsid)}
EOF

        yield(p, i) if block_given?
      end
      attr_doc << <<EOF

Contributing
------------

1. [Find open-source portraits on Flickr][2].
2. In Photoshop, cut to 3:2 ratio and paste to new canvas.
3. Save for web, select Preset: JPEG High, then Maximum. Image sizes:
   640x960px & 320x480px (bicubic sharper for reduction).
4. Make thumbnails with the RMagick rake task: `rake resize`.
     * ImageMagick is required. Otherwise, you can resize the photos manually.
     * Add any Flickr photo ids to `NORTH_GRAVITY_IDS` in `photo.rb` to crop
	   above center.
5. Update your Flickr API Key & today's date in `fake_profile_pictures.rb`.
6. Re-generate `README.md` by running `rake readme`.
7. Send a pull request.
8. Message Flickr user(s) with GitHub link to photo(s) to inform them of use.


Flickr Photo Links
------------------

These are a bunch of links I collected initially.
TODO: Remove the links below for the photos that we already have in this repo.

### Women

* http://www.flickr.com/photos/titlap/3788426000/in/photostream/
* http://www.flickr.com/photos/fromthefrontend/4530910556/in/photostream/
* http://www.flickr.com/photos/robnas/4452457288/in/photostream/
* http://www.flickr.com/photos/teducation/3244887018/sizes/l/in/photostream/
* http://www.flickr.com/photos/webagentur24/2369151434/
* http://www.flickr.com/photos/webagentur24/2368320493/sizes/o/in/photostream/
* http://www.flickr.com/photos/arcticpuppy/5100437401/
* http://www.flickr.com/photos/arcticpuppy/5172802343/in/photostream/
* http://www.flickr.com/photos/hawee/3474008237/
* http://www.flickr.com/photos/pss/4994965909/
* http://www.flickr.com/photos/arcticpuppy/4733974817/sizes/m/in/photostream/
* http://www.flickr.com/photos/titlap/3936827307/
* http://www.flickr.com/photos/pumpkincat210/4890165748/
* http://www.flickr.com/photos/hawee/3377864339/
* http://www.flickr.com/photos/mcgraths/4897110371/
* http://www.flickr.com/photos/johnmcnab/5064560501/in/photostream/
* http://www.flickr.com/photos/arcticpuppy/5173407912/in/photostream/
* http://www.flickr.com/photos/daveiga/3140439835/sizes/l/in/photostream/
* http://www.flickr.com/photos/teducation/3244073185/
* http://www.flickr.com/photos/robnas/4449379623/in/photostream/
* http://www.flickr.com/photos/aehohikaruki/422892014/sizes/o/in/photostream/
* http://www.flickr.com/photos/robboudon/266715501/
* http://www.flickr.com/photos/robnas/5222969552/in/set-72157625504642934/
* http://www.flickr.com/photos/robnas/5498152599/in/set-72157626073192477
* http://www.flickr.com/photos/pumpkincat210/4746689561/in/set-72157624402113002
* http://www.flickr.com/photos/arcticpuppy/4737115585/

### Men

* http://www.flickr.com/photos/36673942@N08/5174950991/in/photostream/
* http://www.flickr.com/photos/brainchildvn/3259370999/
* http://www.flickr.com/photos/titlap/3936813347/in/photostream/
* http://www.flickr.com/photos/titlap/3936777541/in/photostream/
* http://www.flickr.com/photos/titlap/3937523554/in/photostream/
* http://www.flickr.com/photos/titlap/3679345595/in/photostream/
* http://www.flickr.com/photos/mcgraths/4565610991/in/photostream/
* http://www.flickr.com/photos/svenjajan/3555474750/in/photostream/
* http://www.flickr.com/photos/svenjajan/2890368131/
* http://www.flickr.com/photos/robnas/4476799140/in/photostream/
* http://www.flickr.com/photos/robnas/4476798352/in/photostream/
* http://www.flickr.com/photos/robnas/4476020141/in/photostream/
* http://www.flickr.com/photos/carbonnyc/3156504080/
EOF

      puts
      puts "# README.md"
      puts
      puts doc = attr_doc + link_text
      puts
      readme = File.expand_path(File.join(
          File.dirname(__FILE__), "..", "README.md"))
      File.open(readme, "w") { |f| f.write(doc) }
    end
  end
end