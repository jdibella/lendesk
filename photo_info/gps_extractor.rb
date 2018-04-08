module PhotoInfo
  require_relative "services/path_lookup_service"
  require_relative "services/exif_data_extractor_service"
  require_relative "writers/html_writer"
  require_relative "writers/csv_writer"

  class GpsExtractor
    EXTENSIONS = ["jpg", "jpeg", "tiff"]

    def initialize(path:, output: :csv)
      @output = output
      @path = path
    end

    def extract(writer: nil)
      writer ||= Object.const_get("PhotoInfo::#{@output.capitalize}Writer")

      # returns array of paths
      photo_paths = PhotoInfo::PathLookupService.where(path: @path, extensions: EXTENSIONS)

      data = photo_paths
        .collect { |photo_path| PhotoInfo::ExifDataExtractorService.extract(path: photo_path) }
        .compact

      writer.write(data: data)
    end
  end
end