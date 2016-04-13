# https://github.com/igor-alexandrov/xls_to_csv-paperclip-processor
#
# Example Model:
# class SomeCsvAttachement < ActiveRecord::Base
#   has_attached_file :data,
#     styles: {
#       converted: {
#         format: "csv",
#         params: "-c, -q 3"
#       }
#     },
#     path: ":rails_root/data/some_csv_attachements/:id_partition/:basename.:extension",
#     processors: [:xls_to_csv]
#
#   validates_attachment_content_type :data, content_type: ['text/csv','text/comma-separated-values','text/csv','application/csv','application/excel','application/vnd.ms-excel','application/vnd.msexcel','text/anytext','text/plain']
# end

class Paperclip::XlsToCsv < Paperclip::Processor
  attr_accessor :file, :params, :format

  def initialize(file, options = {}, attachment = nil)
    super

    @file           = file
    @params         = options[:params]
    @current_format = File.extname(@file.path)
    @basename       = File.basename(@file.path, @current_format)
    @format         = options[:format]
  end

  def make
    src = @file

    if @current_format && ['.xls','xlsx'].include?(@current_format.downcase)
      dst = Tempfile.new([@basename, @format ? "#{@format}" : 'csv'].compact.join("."))
      begin
        Paperclip.run(self.command, self.parameters(src, dst))
      rescue StandardError => e
        raise "There was an error converting #{@basename} to csv: #{e.message}"
      end
      return dst
    else
      return src 
    end
  end

protected

  def command
    case @current_format
    when '.xls'
      'xls2csv'
    when '.xlsx'
      'xlsx2csv'
    else
      'cp'
    end
  end

  def parameters(src, dst)
    p = []

    if self.command == 'xls2csv'
      p << [@params, File.expand_path(src.path).shellescape, "> #{File.expand_path(dst.path).shellescape}"]
    else
      p << [File.expand_path(src.path).shellescape, File.expand_path(dst.path).shellescape]
    end

    p.flatten.compact.join(" ").strip.squeeze(" ")
  end

end
