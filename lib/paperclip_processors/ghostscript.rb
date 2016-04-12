# https://gist.github.com/bastien/3059321
# Ex. gs -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -dMaxBitmap=500000000 \
#        -dAlignToPixels=0 -dGridFitTT=2 -sDEVICE=jpeg -dTextAlphaBits=4 -dGraphicsAlphaBits=4 \
#        -r150 -sOutputFile=F100001.jpg F100001.pdf
#
module Paperclip
  class Ghostscript < Processor

    attr_accessor :current_geometry, :target_geometry, :format, :whiny, :convert_options, :source_file_options

    def initialize file, options = {}, attachment = nil
      super
      @file                = file
      @format              = options[:format]

      @current_format      = File.extname(@file.path)
      @basename            = File.basename(@file.path, @current_format)
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      dst.binmode

      begin
        if @current_format && @current_format.downcase == ".pdf"
          parameters = []
          # parameters << "-dNOPAUSE -dBATCH -sDEVICE=jpeg -r144 -dUseCIEColor -dFirstPage=1 -dLastPage=1"
          # parameters << "-dFirstPage=1 -dLastPage=1"
          parameters << "-q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -dMaxBitmap=500000000 -dAlignToPixels=0"
          parameters << "-dGridFitTT=2 -sDEVICE=jpeg -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -r150"
          parameters << "-sOutputFile=:dest"
          parameters << ":source"

          parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

          Paperclip.run("gs", parameters, source: "#{File.expand_path(src.path)}", dest: File.expand_path(dst.path))
          return dst
        else
          return src
        end
      rescue Cocaine::CommandNotFoundError => _
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if @whiny
      end
    end
  end
end

