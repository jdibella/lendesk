RSpec.describe PhotoInfo::HtmlWriter do
  describe "#write" do
    let(:data) { [{file: "one.jpg", longitude: 1.11, latitude: 2.22}] }
    subject { described_class.new(data: data).write(filename: "test.html") }
    after { File.delete("test.html") }

    it "writes a csv file with correct data" do
      subject
      output = File.open("test.html") {|io| io.read }
      expect(output).to eq expected_html
    end

    def expected_html
      <<~HTML
        <html>
        <head>
          <title>Extracted Photo GPS Data</title>
        </head>
        <body>
          <table>
            <thead>
              <th>File</th>
              <th>Longitude</th>
              <th>Latitude</th>
            </thead>
            <tbody>
              <tr>
          <td>one.jpg</td>
          <td>1.11</td>
          <td>2.22</td>
        </tr>

            </tbody>
          </table>
        </body>
      HTML
    end
  end
end