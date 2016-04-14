require 'paperclip'
Dir[File.dirname(__FILE__) + '/paperclip_processors/*.rb'].each {|file| require file }

module Paperclip
  class Utils
    def self.get_processors(content_type, processors: [:thumbnail], fallback_processors: [], allowed_content_types: ALLOWED_CONTENT_TYPES)
      if processors != []
        if processors.is_a?(Array)
          if processors.include?(:thumbnail) && content_type == 'application/pdf' && !processors.include?(:ghostscript)
            processors.unshift(:ghostscript)
          end
        elsif processors.is_a?(Symbol)
          processors = [processors]
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

    def self.get_styles(content_type, styles: {preview: "600x800>", thumb: "100x100>"}, fallback_styles: {}, allowed_content_types: ALLOWED_CONTENT_TYPES)
      if styles.is_a?(Hash)
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type)
          styles.each do |k,v|
            if v.is_a?(String)
              styles[k] = [v, :jpg]
            end
          end
        end
      else
        styles = {}
      end
      return (allowed_content_types.include?(content_type) ? styles : fallback_styles)
    end

    ALLOWED_CONTENT_TYPES = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif', 'image/tiff', 'image/x-tiff']
  end
end
