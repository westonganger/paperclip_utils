# Paperclip Utils
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=VKY8YAWAS5XRQ&lc=CA&item_name=Weston%20Ganger&item_number=paperclip_utils&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest" target="_blank" title="Donate"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate"/></a>

Paperclip Utils is a helper class for easier dynamic processors and styles on your Paperclip file uploads


# Install
```ruby
gem install paperclip_utils
```


Paperclip Utils contains the following methods:
```ruby
Paperclip::Utils.get_processors(content_type, processors_if_allowed, fallback_processors, allowed_content_types)

Paperclip::Utils.get_styles(content_type, styles_if_allowed, fallback_processors, allowed_content_types)
```


# Usage
```ruby
class Post < ActiveRecord::Base
  has_attachment :my_attachment, 
    styles: lambda{|x| Paperclip::Utils.get_styles(x.instance.my_attachment.content_type) }, 
    processors: lambda{|x| Paperclip::Utils.get_processors(x.my_attachment.content_type) },
    path: "public/system/:class/:attachment/:id_partition/:style/:filename",
    url: "#{ActionController::Base.relative_url_root}/system/:class/:attachment/:id_partition/:style/:filename"
end
```



# Methods

**get_processors** - `String(file content_type), Array(optional - default=[:ghostscript,:thumbnail]), Array(optional - default=[]), Array(optional - allowed content types)`

**get_styles** - `String(file content type)Hash(optional - default={preview: "800x600>", thumb: "100x100>"}), Hash(optional - default={}), Array(optional - allowed content types)`

**ALLOWED_CONTENT_TYPES** - Default allowed content types. `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']`



# Credits
Created by Weston Ganger - @westonganger

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=VKY8YAWAS5XRQ&lc=CA&item_name=Weston%20Ganger&item_number=paperclip_utils&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest" target="_blank" title="Donate"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate"/></a>
