require 'paperclip'
require 'paperclip_processors/ghostscript.rb'

module Paperclip
  class Utils
    def self.get_processors(content_type, to_processors=nil, fallback_processors=[], allowed_content_types=ALLOWED_CONTENT_TYPES)
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

    def self.get_styles(content_type, to_styles=nil, fallback_styles={}, allowed_content_types=ALLOWED_CONTENT_TYPES)
      if to_styles
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type) && to_styles.any?{|k,v| v.is_a?(String)}
          to_styles.each do |k,v|
            to_styles[k] = [v, :png]
          end
        end
      else
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type)
          to_styles = {preview: ["800x600>", :png], thumb: ["100x100>", :png]}
        else
          to_styles = {preview: "800x600>", thumb: "100x100>"}
        end
      end
      return (allowed_content_types.include?(content_type) ? to_styles : fallback_styles)
    end

    ALLOWED_CONTENT_TYPES = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif', 'image/tiff', 'image/x-tiff']
  end
end
