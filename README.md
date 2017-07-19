# Paperclip Utils

Paperclip Utils is a helper class for easier dynamic processors and styles on your Paperclip file uploads. It also has a collection of custom Paperclip processors.


# Install
```
gem install paperclip_utils
```

# Custom Processors
**Ghostscript** - `:ghostscript` - Fixes black boxes and errors thumbnail processing for PDF files. This is automatically included if processors includes :thumbnail which it does by default

**XLS to CSV** - `:xls_to_csv` - Converts XLS/XLSX files to CSV

**PDF Merge** - `:pdf_merge` - A way to handle multiple pdf uploads, requires some custom wiring, must add a `pdf_files` method to your model and temporarily save files with this though.

Check the processor source to see examples if required. [See all processors & examples here](https://github.com/westonganger/paperclip_utils/tree/master/lib/paperclip_processors).

# Helpers Methods

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

### Paperclip::Utils.get_styles(content_type, *optional_options)

| Option | Type | Default | Notes |
|---|:--:|:--:|---|
| **styles** | Array| `{ preview: '600x800>'}` | Default file type for each style is .jpg for uploaded .pdf and .tif file |
| **fallback_styles** | Hash | `{}` |  These are the styles applied if the files content type is in the allowed list below. |
| **allowed_content_types** | Array | `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']` | |

<br>

### Paperclip::Utils.get_processors(content_type, *optional_options)

| Option | Type | Default | Notes |
|---|:--:|:--:|---|
| **processors** | Array| `[:ghostscript, :thumbnail]` | Automatically includes ghostscript processor if processors includes :thumbnail which it does by default |
| **fallback_processors** | Hash | `[]` |  These are the processors applied if the files content type is in the allowed list below. |
| **allowed_content_types** | Array | `['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']` | |


# Credits
Created by Weston Ganger - [@westonganger](https://github.com/westonganger)

<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='32' style='border:0px;height:32px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee' /></a> 
