module PhotoInfo
  require_relative "../exif_coordinate"
  require 'exif'

  class ExifDataExtractorService
    def self.extract(path:)
      new(path: path).extract
    end

    def initialize(path:)
      @path = path
    end

    def extract
      return nil if @path.nil? || @path.length == 0

      begin
        metadata  = Exif::Data.new(File.open(@path))
        longitude = ExifCoordinate.to_f(
          rationals: metadata.gps_longitude,
          direction: metadata.gps_longitude_ref
        )
        latitude  = ExifCoordinate.to_f(
          rationals: metadata.gps_latitude,
          direction: metadata.gps_latitude_ref
        )

        {
          file: @path.split("/").pop,
          latitude:  latitude,
          longitude: longitude
        }
      rescue Exif::NotReadable => e
        puts "WARNING: Unable to read metadata for photo: #{@path}"
      end
    end
  end
end