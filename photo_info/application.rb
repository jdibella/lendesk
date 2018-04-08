module PhotoInfo
  require_relative "option_parser"
  require_relative "gps_extractor"

  class Application
    def self.run
      options = PhotoInfo::OptionParser.parse(ARGV)
      extractor = PhotoInfo::GpsExtractor.new(path: options.directory, output: options.output)
      new(extractor: extractor).run
    end

    def initialize(extractor:)
      @extractor = extractor
    end

    def run
      @extractor.extract
    end
  end
end