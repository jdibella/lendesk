module PhotoInfo
  class SimpleWriter
    require 'csv'

    def self.write(data:)
      new(data: data).write
    end

    def initialize(data:)
      @data = data
    end

    def write
      msg = "You must provide an implementation of `write` in the subclass."
      raise ArgumentError, msg
    end
  end
end