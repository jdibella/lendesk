# Photo Gps Info Extractor

This program can be run via:
* `ruby app.rb` (defaults to current directory)
* `ruby app.rb --source /path/to/dir` (sets the source directory)
* `ruby app.rb --html` (changes output to html)

CSV output is saved to `output.csv` and HTML output to `output.html`.

## Dependencies
* libexif (`brew install libexif`)
* bundler (`gem install bundler`)

## Installing Required Gems
* `bundle install` will install all other dependencies once bundler gem has been installed

## Running Tests
* all tests can be run via `bundle exec rspec`

## Technical Considerations

*Gems:*
I picked the `exif` gem because of the underlying c implementation, which makes it a
performant solution.

*Code Structure:*

A lot of the classes have patterns like `GpsExtractor.extract(writer: SomeWriter)`.
This was done because the requirements were to support both html and csv outputs. Injecting the dependency that plays the role of the writer in the method definition allows for _any_ object
that plays the 'writer' role. This allows flexibility in two ways:
* adding more writers becomes easy
* testing the Extractor class can be done by passing a fake `writer` object, so that the test doesn't have to care about the writer actually doing anything (assuming the individual writer object is itself under test somewhere)

The specs for this project leverage the dependency injection mentioned above to introduce mocks for unrelated functionality (ex: calls to the csv writer inside the gps extraction logic).


