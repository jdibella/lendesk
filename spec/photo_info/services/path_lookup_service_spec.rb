RSpec.describe PhotoInfo::PathLookupService do
  describe "self.where" do
    subject { described_class.where(path: "/Some/Path/", extensions: ["jpeg", "tiff"]) }

    it "calls `Dir.glob` with the correct pattern" do
      expect(Dir).to receive(:glob).with("/Some/Path/**/*.{jpeg,tiff}")
      subject
    end
  end
end