module PhotoInfo
  require_relative "gps_extractor"

  class Application
    def self.run
      new.run
    end

    def initialize(extractor: PhotoInfo::GpsExtractor)
      validate_output!(ARGV[1])
      output = ARGV[1] || "csv"
      output = output.downcase.to_sym

      @extractor = extractor.new(path: path_from_input(ARGV[0]), output: output )
    end

    def run
      @extractor.extract
    end

    private

    def validate_output!(output)
      output ||= "csv"
      types = ["html", "csv"]
      return if types.include?(output.downcase)

      raise ArgumentError, "Invalid output type : #{output}, valid types are #{types.join", "}"
    end

    def path_from_input(path)
      return Dir.pwd if path.nil?
      return path if path.match(/\/$/)
      "#{path}/"
    end
  end
end