RSpec.describe PhotoInfo::Application do
  let(:extractor) { double("extractor") }
  describe "#run" do
    subject { described_class.new(extractor: extractor).run }

    it "calls extract on the extractor" do
      expect(extractor).to receive(:extract)
      subject
    end
  end
end
