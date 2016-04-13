# Merge pdf files (for transmittals)
#https://gist.github.com/jessieay/5832466
# Ex. http://stackoverflow.com/questions/17203270/combine-multi-page-pdfs-into-one-pdf-with-imagemagick
#
# First save your files to a temporary location then save your model with any arbitrary file attached which will not be saved.
#
# Example Model:
# class SomeCsvAttachement < ActiveRecord::Base
#   has_attached_file :data,
#     path: ":rails_root/data/some_csv_attachements/:id_partition/:basename.:extension",
#     processors: [:pdf_merge]
#
#   def pdf_files
#     base_path = File.join(Rails.root, 'tmp')
#     
#     # Specific files
#     [ File.join(base_path, 'path/to/file.pdf'), File.join(base_path, 'another/file/path.pdf') ]
#     
#     # Or all files in a folder
#     Dir.glob(File.join(base_path,"/path/to/folder/*"))
#   end
#
#   validates_attachment_content_type :data, content_type: ['application/pdf']
# end

module Paperclip
  class PdfMerge < Processor

    def initialize file, options = {}, attachment = nil
      super
      @format = File.extname(@file.path)
      @basename = File.basename(@file.path, @format)
      @files = attachment.instance.pdf_files
    end

    def make
      src = @file
      if @current_format && @current_format.downcase == '.pdf'
        dst = Tempfile.new([@basename, @format])
        dst.binmode

        file_paths = @files.map {|file| "#{Rails.root}/tmp/#{file.original_filename}"}

        all_page_file_paths = ""

        file_paths.each do |file_path|
          pdf = PDF::Reader.new(file_path)
          count = pdf.page_count
          counter = 0

          count.times do
            all_page_file_paths += "#{file_path}[#{counter}] "
            counter += 1
          end
        end

         Paperclip.run(
           'convert',
           "-density 150 #{all_page_file_paths} #{File.expand_path(dst.path)}"
          )

        return dst
      else
        return src
      end
    end

  end
end
