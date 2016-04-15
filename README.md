# Paperclip Utils
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=VKY8YAWAS5XRQ&lc=CA&item_name=Weston%20Ganger&item_number=paperclip_utils&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest" target="_blank" title="Donate"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate"/></a>

Paperclip Utils is a helper class for easier dynamic processors and styles on your Paperclip file uploads. It also has a collection of custom Paperclip processors.


# Install
```ruby
# requires ruby >= 2.0
gem install paperclip_utils
```

# Custom Processors
**Ghostscript** - `:ghostscript` - Fixes black boxes and errors thumbnail processing for PDF files. This is automatically included if processors includes :thumbnail which it does by default

**XLS to CSV** - `:xls_to_csv` - Converts XLS/XLSX files to CSV

**PDF Merge** - `:pdf_merge` - A way to handle multiple pdf uploads, requires some custom wiring, must add a `pdf_files` method to your model and temporarily save files with this though.

Check the processor source to see examples if required. [See all processors & examples here](https://github.com/westonganger/paperclip_utils/tree/master/lib/paperclip_processors).


# Helper Methods Usage
```ruby
class Post < ActiveRecord::Base
  has_attachment :my_attachment, 
    styles: lambda{|x| Paperclip::Utils.get_styles(x.instance.my_attachment.content_type) }, 
    processors: lambda{|x| Paperclip::Utils.get_processors(x.my_attachment.content_type) },
    path: "public/system/:class/:attachment/:id_partition/:style/:filename",
    url: "#{ActionController::Base.relative_url_root}/system/:class/:attachment/:id_partition/:style/:filename"
end

# OR using any or all of the custom options

class Post < ActiveRecord::Base
  has_attachment :my_attachment, 
    styles: lambda{|x| Paperclip::Utils.get_styles(x.instance.my_attachment.content_type, styles: {preview: "800x600>", thumb: "100x100>"}, fallback_styles: nil, allowed_content_types: ['application/pdf']) }, 
    processors: lambda{|x| Paperclip::Utils.get_processors(x.my_attachment.content_type, processors: [:thumbnail, :some_other_custom_processor], fallback_processors: [:another_custom_processor], allowed_content_types: ['application/pdf']) },
    path: "public/system/:class/:attachment/:id_partition/:style/:filename",
    url: "#{ActionController::Base.relative_url_root}/system/:class/:attachment/:id_partition/:style/:filename"
end
```

# Helper Methods & Options

<br>
##### `Paperclip::Utils.get_styles(content_type, *optional_options)`
| Option | Type | Default | Notes |
|---|:--:|:--:|---|
| **styles** | Array| `{ preview: '600x800>'}` | Default file type for each style is .jpg for uploaded .pdf and .tif file |
| **fallback_styles** | Hash | `{}` |  These are the styles applied if the files content type is in the allowed list below. |
| **allowed_content_types** | Array | `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']` | |

<br>
##### `Paperclip::Utils.get_processors(content_type, *optional_options)`
**processors** - Array - Default: `[:ghostscript, :thumbnail]` - Notes: Automatically includes ghostscript processor if processors includes :thumbnail which it does by default

**fallback_processors** - Array - Default: `[]` - These are the processors applied if the files content type is in the allowed list below.

**allowed_content_types** - Array - Default: `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']`

| Option | Type | Default | Notes |
|---|:--:|:--:|---|
| **processors** | Array| `[:ghostscript, :thumbnail]` | Automatically includes ghostscript processor if processors includes :thumbnail which it does by default |
| **fallback_processors** | Hash | `[]` |  These are the processors applied if the files content type is in the allowed list below. |
| **allowed_content_types** | Array | `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']` | |


# Credits
Created by Weston Ganger - @westonganger

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=VKY8YAWAS5XRQ&lc=CA&item_name=Weston%20Ganger&item_number=paperclip_utils&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_SM%2egif%3aNonHostedGuest" target="_blank" title="Donate"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="Donate"/></a>
