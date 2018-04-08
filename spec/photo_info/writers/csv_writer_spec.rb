RSpec.describe PhotoInfo::CsvWriter do
  describe "#write" do
    let(:data) { [{file: "one.jpg", longitude: 1.11, latitude: 2.22}] }
    subject { described_class.new(data: data).write(filename: "test.csv") }
    after { File.delete("test.csv") }

    it "writes a csv file with correct data" do
      subject
      output = CSV.readlines("test.csv")
      expect(output).to eq([["file", "longitude", "latitude"], ["one.jpg", "1.11", "2.22"]])
    end
  end
end