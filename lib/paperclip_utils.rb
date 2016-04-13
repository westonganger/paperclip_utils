require 'paperclip'
require 'paperclip_processors/ghostscript.rb'

module Paperclip
  class Utils
    def self.get_processors(content_type, options={to_processors: [:thumbnail], fallback_processors: [], allowed_content_types: ALLOWED_CONTENT_TYPES})
      if options[:to_processors]
        if options[:to_processors].is_a?(Array)
          processors = options[:to_processors]

          if processors.include?(:thumbnail) && content_type == 'application/pdf' && !processors.include?(:ghostscript)
            processors.unshift(:ghostscript)
          end
        elsif options[:to_processors].is_a?(Symbol)
          processors = [options[:to_processors]]
        else
          processors = []
        end
      end
      
      if options[:fallback_processors] != []
        if options[:fallback_processors].is_a?(Array)
          fallback_processors = options[:fallback_processors]
        elsif options[:fallback_processors].is_a?(Symbol)
          fallback_processors = [options[:fallback_processors]]
        else
          fallback_processors = []
        end
      end
      
      return (allowed_content_types.include?(content_type) ? processors : fallback_processors)
    end

    def self.get_styles(content_type, options={to_styles: nil, fallback_styles: {}, allowed_content_types: ALLOWED_CONTENT_TYPES})
      to_styles = options[:to_styles]

      if to_styles
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type)
          to_styles.each do |k,v|
            to_styles[k] = [(v.is_a?(String) ? v : v[0]), :jpg]
          end
        end
      else
        if ['application/pdf','image/tiff','image/tif','image/x-tiff'].include?(content_type)
          to_styles = {preview: ["800x600>", :jpg], thumb: ["100x100>", :jpg]}
        else
          to_styles = {preview: "800x600>", thumb: "100x100>"}
        end
      end
      return (options[:allowed_content_types].include?(content_type) ? to_styles : options[:fallback_styles])
    end

    ALLOWED_CONTENT_TYPES = ['application/pdf', 'image/png', 'image/x-png', 'image/gif', 'image/jpeg', 'image/pjpeg', 'image/jpg', 'image/tif', 'image/tiff', 'image/x-tiff']
  end
end
