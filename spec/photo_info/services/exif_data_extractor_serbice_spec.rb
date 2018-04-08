RSpec.describe PhotoInfo::ExifDataExtractorService do
  describe "#extract" do
    let(:path) { nil }
    subject { described_class.new(path: path).extract }
    context "when path is nil" do
      it { is_expected.to eq nil }
    end

    context "when path is provided" do
      let(:path) { "/Some/Path/here.jpg" }
      let(:fake_data) do
        OpenStruct.new(
          gps_longitude: [Rational(5/1) ,Rational(5/1), Rational(5/1)],
          gps_latitude: [Rational(5/1) ,Rational(5/1), Rational(5/1)],
          gps_longitude_ref: "W",
          gps_latitude_ref: "S"
        )
      end
      let(:expected_data) { { file: "here.jpg", longitude: 1.11, latitude: 1.11 } }
      before do
        allow(File).to receive(:open)
        allow(Exif::Data).to receive(:new).and_return(fake_data)
        allow(PhotoInfo::ExifCoordinate).to receive(:to_f).and_return(1.11)
      end

      it { is_expected.to eq expected_data }
    end

  end
end