require 'paperclip'
require 'paperclip_processors/ghostscript.rb'

module Paperclip
  class Utils
    def self.get_paperclip_processors(content_type, to_processors=nil, fallback_processors=[], allowed_content_types=PAPERCLIP_UTILS_ALLOWED_CONTENT_TYPES)
      if to_processors && to_processors.is_a?(Array)
        processors = to_processors
      end

      if content_type == 'application/pdf'
        processors ||= [:ghostscript, :thumbnail]
      else
        processors ||= [:thumbnail]
      end
      
      return (allowed_content_types.include?(content_type) ? processors : fallback_processors)
    end

    def self.get_paperclip_styles(content_type, to_styles={preview: "800x600>", thumb: "100x100>"}, fallback_styles={}, allowed_content_types=PAPERCLIP_UTILS_ALLOWED_CONTENT_TYPES)
      return (allowed_content_types.include?(content_type) ? to_styles : fallback_styles)
    end

    PAPERCLIP_UTILS_ALLOWED_CONTENT_TYPES = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif, ''image/tiff', 'image/x-tiff']
  end
end
