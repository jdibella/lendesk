module PhotoInfo
  require_relative "exif_coordinate"
  require_relative "writers/html_writer"
  require_relative "writers/csv_writer"
  require 'exif'

  class GpsExtractor
    EXTENSIONS = ["jpg", "jpeg", "gif", "png", "tiff"]

    def initialize(path:, output: :csv)
      @output = output
      @path = path
    end

    def extract(writer: nil)
      writer ||= Object.const_get("PhotoInfo::#{@output.capitalize}Writer")
      data = photo_paths
        .collect { |photo_path| data_for_photo(path: photo_path) }
        .compact

      writer.write(data: data)
    end

    private

    def data_for_photo(path: nil)
      return nil if path.nil? || path.length == 0
      begin
        metadata  = Exif::Data.new(File.open(path))
        longitude = ExifCoordinate.to_f(
          rationals: metadata.gps_longitude,
          dir: metadata.gps_longitude_ref
        )
        latitude  = ExifCoordinate.to_f(
          rationals: metadata.gps_latitude,
          dir: metadata.gps_latitude_ref
        )

        {
          file: path.split("/").pop,
          latitude:  latitude,
          longitude: longitude
        }
      rescue Exif::NotReadable => e
        puts "Unable to read exif data for photo: #{path}, skipping"
      end
    end

    def photo_paths
      extensions = EXTENSIONS + EXTENSIONS.map(&:upcase)
      pattern = "#{@path}**/*.{#{extensions.join(",")}}"
      Dir.glob(pattern)
    end
  end
end