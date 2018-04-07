module PhotoInfo
  require_relative "simple_writer"

  class CsvWriter < SimpleWriter
    def write
      ::CSV.open("output.csv", "w") do |csv|
        csv << ["file", "longitude", "latitude"]
        @data.each do |item|
          csv << [item[:file], item[:longitude], item[:latitude]]
        end
      end
    end
  end
end