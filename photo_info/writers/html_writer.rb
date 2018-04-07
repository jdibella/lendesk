module PhotoInfo
  require_relative "simple_writer"

  class HtmlWriter < SimpleWriter
    def write
      rows = @data.collect do |item|
        <<-ROW
          <tr>
            <td>#{item[:file]}</td>
            <td>#{item[:longitude]}</td>
            <td>#{item[:latitude]}</td>
          </tr>
        ROW
      end

      html = <<-HTML
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
              #{rows.join("\n")}
            </tbody>
          </table>
        </body>
      HTML

      File.open("output.html", "w") { |file| file.write(html) }
    end
  end
end