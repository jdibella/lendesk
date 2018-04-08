RSpec.describe PhotoInfo::Application do
  let(:extractor) { double("extractor") }
  describe "#run" do
    subject { described_class.new(extractor: extractor).run }

    it "calls extract on the extractor" do
      expect(extractor).to receive(:extract)
      subject
    end
  end

  describe "self.run" do
    subject { described_class.run }
    let(:options) { OpenStruct.new(directory: "/Some/Path/", output: "html") }
    let(:fake_writer) { double("writer") }
    before do
      allow(fake_writer).to receive(:extract)
      allow(PhotoInfo::OptionParser).to receive(:parse).and_return(options)
    end

    it "makes a new extractor with path and output params" do
      expect(PhotoInfo::GpsExtractor).to receive(:new)
        .with({ path: "/Some/Path/", output: "html" })
        .and_return(fake_writer)
      subject
    end
  end
end
