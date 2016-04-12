module Paperclip
  class Utils
    def self.get_processors(content_type, to_processors=nil, fallback_processors=[])
      if to_processors && to_processors.is_a?(Array)
        processors = to_processors
      end

      if File.exist?(File.join(Rails.root, 'lib/paperclip/ghostscript.rb')) || File.exist?(File.join(Rails.root, 'lib/paperclip_processors/ghostscript.rb'))
        processors ||= [:ghostscript, :thumbnail]
      else
        processors ||= [:thumbnail]
      end
      
      return (ALLOWED.include?(content_type) ? processors : fallback_processors)
    end

    def self.get_styles(content_type=nil, to_styles={preview: "800x600>", thumb: "100x100>"}, fallback_styles={})
      return (ALLOWED.include?(content_type) ? to_styles : fallback_styles)
    end

    ALLOWED = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']

    VERSION = '1.0.0'
  end
end
