module PhotoInfo
  require_relative "simple_writer"

  class CsvWriter < SimpleWriter
    def write(filename: "output.csv")
      ::CSV.open(
        filename,
        "w",
        write_headers: true,
        headers: ["file", "longitude", "latitude"]
      ) do |csv|
        @data.each do |item|
          csv << [item[:file], item[:longitude], item[:latitude]]
        end
      end
    end
  end
end