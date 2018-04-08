RSpec.describe PhotoInfo::GpsExtractor do
  describe "#extract" do
    let(:file) { "one.jpg" }
    let(:fake_exif_data) { { file: file, latitude: 3.14, longitude: 8.675309 } }
    let(:fake_writer) { double("writer") }
    let(:path) { "/fake/path/" }
    let(:output) { "csv" }

    before do
      allow(PhotoInfo::PathLookupService).to receive(:where).and_return([file])
      allow(PhotoInfo::ExifDataExtractorService).to receive(:extract).and_return(fake_exif_data)
    end

    it "calls the writer's write method with data" do
      expect(fake_writer).to receive(:write).with({ data: [fake_exif_data] })
      described_class
        .new(path: path, output: output)
        .extract(writer: fake_writer)
    end
  end
end
