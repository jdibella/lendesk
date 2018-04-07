# Photo Gps Info Extractor

This program can be run via:
* `ruby app.rb` (defaults to current directory)
* `ruby app.rb /path/to/folder` (for `csv` output, saved to `output.csv`)
* `ruby app.rb /path/to/folder html` (for `html` output, saved to `output.html`)

## App Structure
Because of the small nature of this example, I've included all of the namepsaced classes
inline in `app.rb`. However, in a real-world example, the structure would look like:
* /
** gps_extractor.rb
** exif_coordinate.rb
** app.rb
** /writers
***  csv_writer.rb
***  html_writer.rb

with the appropriate `require` statements in `app.rb`.

## Dependencies

### Libexif
* `brew install libexif`
* `gem install exif`

### CSV
* `gem install csv`

## Technical Considerations

_Gems:_
I picked the `exif` gem because of the underlying c implementation, which makes it a
performant solution.

_Code Structure:_

A lot of the classes have patterns like `GpsExtractor.extract(writer: SomeWriter)`.
This was done because the requirements were to support both html and csv outputs. Injecting the
dependency that plays the role of the writer in the method definition allows for _any_ object
that plays the 'writer' role. This allows flexibility in two ways:
* adding more writers becomes easy
* testing the Extractor class can be done by passing a fake `writer` object, so that the test
doesn't have to care about the writer actually doing anything (assuming the individual writer object
  is itself under test somewhere)
