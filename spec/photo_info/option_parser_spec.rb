RSpec.describe PhotoInfo::OptionParser do
  describe "self.parse" do
    let(:args) { [] }
    subject { described_class.parse(args) }

    context "when no options are provided" do
      # full path for project root
      let(:path) { File.expand_path("../..", File.dirname(__FILE__)) }
      let(:default_options) { OpenStruct.new(directory: "#{path}/", output: "csv") }

      it { is_expected.to eq default_options }
    end

    context "when source is provided" do
      let(:args) { ["--source=/Some/Dir"] }
      let(:default_options) { OpenStruct.new(directory: "/Some/Dir/", output: "csv") }

      it { is_expected.to eq default_options }
    end

    context "when html flag is provided" do
      let(:args) { ["--html"] }
      let(:path) { File.expand_path("../..", File.dirname(__FILE__)) }
      let(:default_options) { OpenStruct.new(directory: "#{path}/", output: "html") }
      it { is_expected.to eq default_options }
    end
  end
end