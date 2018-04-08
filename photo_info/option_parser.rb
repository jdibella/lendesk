module PhotoInfo
  require "optparse"
  require 'ostruct'

  class OptionParser
    def self.parse(args)
      options = OpenStruct.new
      options.directory = "#{Dir.pwd}/"
      options.output = "csv"

      opt_parser = ::OptionParser.new do |opts|
        opts.banner = "Usage: ruby app.rb [options]"

        opts.separator ""
        opts.separator " When no arguments provided, defaults to csv output and current directory source."
        opts.separator "Specific options:"

        opts.on(
          "--source PATH",
          "Set the source directory path",
          "  (defaults to current directory if no directory supplied)"
        ) do |source|
          source += "/" unless source.match(/\/$/)
          options.directory = source
        end

        opts.on(
          "--html",
          "Set the outpt format to html",
          "  (defaults to csv output if not specified)"
        ) do |output|
          options.output = "html"
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      opt_parser.parse!(args)

      options
    end
  end
end