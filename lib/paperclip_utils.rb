require 'paperclip'
require 'paperclip_processors/ghostscript.rb'

module Paperclip
  class Utils
    def self.get_processors(content_type, to_processors: [:thumbnail], fallback_processors: [], allowed_content_types: ALLOWED_CONTENT_TYPES)
      if to_processors
        if to_processors.is_a?(Array)
          processors = to_processors

          if processors.include?(:thumbnail) && content_type == 'application/pdf' && !processors.include?(:ghostscript)
            processors.unshift(:ghostscript)
          end
        elsif to_processors.is_a?(Symbol)
          processors = [to_processors]
        else
          processors = []
        end
      end
      
      if fallback_processors != []
        if fallback_processors.is_a?(Array)
          fallback_processors = fallback_processors
        elsif fallback_processors.is_a?(Symbol)
          fallback_processors = [fallback_processors]
        else
          fallback_processors = []
        end
      end
      
      return (allowed_content_types.include?(content_type) ? processors : fallback_processors)
    end

    def self.get_styles(content_type, to_styles: {preview: "800x600>", thumb: "100x100>"}, fallback_styles: {}, allowed_content_types: ALLOWED_CONTENT_TYPES)
      if to_styles
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type)
          to_styles.each do |k,v|
            to_styles[k] = [(v.is_a?(String) ? v : v[0]), :jpg]
          end
        end
      else
        to_styles = []
      end
      return (allowed_content_types.include?(content_type) ? to_styles : fallback_styles)
    end

    ALLOWED_CONTENT_TYPES = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif', 'image/tiff', 'image/x-tiff']
  end
end
