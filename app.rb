# module PhotoInfo
#   # class SimpleWriter
#   #   require 'csv'

#   #   def self.write(data:)
#   #     new(data: data).write
#   #   end

#   #   def initialize(data:)
#   #     @data = data
#   #   end

#   #   def write
#   #     msg = "You must provide an implementation of `write` in the subclass."
#   #     raise ArgumentError, msg
#   #   end
#   # end

#   # class CsvWriter < SimpleWriter
#   #   def write
#   #     ::CSV.open("output.csv", "w") do |csv|
#   #       csv << ["file", "longitude", "latitude"]
#   #       @data.each do |item|
#   #         csv << [item[:file], item[:longitude], item[:latitude]]
#   #       end
#   #     end
#   #   end
#   # end

#   # class HtmlWriter < SimpleWriter
#   #   def write
#   #     rows = @data.collect do |item|
#   #       <<-ROW
#   #         <tr>
#   #           <td>#{item[:file]}</td>
#   #           <td>#{item[:longitude]}</td>
#   #           <td>#{item[:latitude]}</td>
#   #         </tr>
#   #       ROW
#   #     end

#   #     html = <<-HTML
#   #       <html>
#   #       <head>
#   #         <title>Extracted Photo GPS Data</title>
#   #       </head>
#   #       <body>
#   #         <table>
#   #           <thead>
#   #             <th>File</th>
#   #             <th>Longitude</th>
#   #             <th>Latitude</th>
#   #           </thead>
#   #           <tbody>
#   #             #{rows.join("\n")}
#   #           </tbody>
#   #         </table>
#   #       </body>
#   #     HTML

#   #     File.open("output.html", "w") { |file| file.write(html) }
#   #   end
#   # end

#   # class ExifCoordinate
#   #   def self.to_f(rationals: [], dir:)
#   #     new(rationals: rationals, dir: dir).to_f
#   #   end

#   #   def initialize(rationals: [], dir:)
#   #     @rationals = rationals
#   #     @dir = dir
#   #   end

#   #   def to_f
#   #     return nil if @rationals.nil? || @rationals.empty?

#   #     degrees = @rationals[0] || 0
#   #     minutes = @rationals[1] || 0
#   #     seconds = @rationals[2] || 0

#   #     sign = 1
#   #     sign = -1 if ["W", "S"].include?(@dir)
#   #     sign * (degrees + minutes/60 + seconds/3600).to_f
#   #   end
#   # end

#   # class GpsExtractor
#   #   require 'exif'

#   #   EXTENSIONS = ["jpg", "jpeg", "gif", "png", "tiff"]

#   #   def initialize(path:, output: :csv)
#   #     @output = output
#   #     @path = path
#   #   end

#   #   def extract(writer: nil)
#   #     writer ||= Object.const_get("PhotoInfo::#{@output.capitalize}Writer")
#   #     data = photo_paths
#   #       .collect { |photo_path| data_for_photo(path: photo_path) }
#   #       .compact

#   #     writer.write(data: data)
#   #   end

#   #   private

#   #   def data_for_photo(path: nil)
#   #     return nil if path.nil? || path.length == 0
#   #     begin
#   #       metadata  = Exif::Data.new(File.open(path))
#   #       longitude = ExifCoordinate.to_f(
#   #         rationals: metadata.gps_longitude,
#   #         dir: metadata.gps_longitude_ref
#   #       )
#   #       latitude  = ExifCoordinate.to_f(
#   #         rationals: metadata.gps_latitude,
#   #         dir: metadata.gps_latitude_ref
#   #       )

#   #       {
#   #         file: path.split("/").pop,
#   #         latitude:  latitude,
#   #         longitude: longitude
#   #       }
#   #     rescue Exif::NotReadable => e
#   #       puts "Unable to read exif data for photo: #{path}, skipping"
#   #     end
#   #   end

#   #   def photo_paths
#   #     extensions = EXTENSIONS + EXTENSIONS.map(&:upcase)
#   #     pattern = "#{@path}**/*.{#{extensions.join(",")}}"
#   #     Dir.glob(pattern)
#   #   end
#   # end

#   # class Application
#   #   def self.run
#   #     new.run
#   #   end

#   #   def initialize(extractor: PhotoInfo::GpsExtractor)
#   #     validate_output!(ARGV[1])
#   #     output = ARGV[1] || "csv"
#   #     output = output.downcase.to_sym

#   #     @extractor = extractor.new(path: path_from_input(ARGV[0]), output: output )
#   #   end

#   #   def run
#   #     @extractor.extract
#   #   end

#   #   private

#   #   def validate_output!(output)
#   #     output ||= "csv"
#   #     types = ["html", "csv"]
#   #     return if types.include?(output.downcase)

#   #     raise ArgumentError, "Invalid output type : #{output}, valid types are #{types.join", "}"
#   #   end

#   #   def path_from_input(path)
#   #     return Dir.pwd if path.nil?
#   #     return path if path.match(/\/$/)
#   #     "#{path}/"
#   #   end
#   # end
# end

require "./photo_info/application"

PhotoInfo::Application.run