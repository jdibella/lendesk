RSpec.describe PhotoInfo::ExifCoordinate do
  describe "#to_f" do
    context "when given rationals and a direction" do
      # vancouver latitude in rationals
      let(:rationals) { [Rational(49/1), Rational(15/1), Rational(275_429/10_000)] }
      let(:direction) { "N" }
      subject { described_class.new(rationals: rationals, direction: direction).to_f }

      it { is_expected.to eq 49.2575 }

      context "when direction flips orientation" do
        let(:direction) { "S" }
        it { is_expected.to eq -49.2575 }
      end
    end
  end
end