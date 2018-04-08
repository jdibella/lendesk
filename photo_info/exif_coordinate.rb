module PhotoInfo
  class ExifCoordinate
    def self.to_f(rationals: [], direction:)
      new(rationals: rationals, direction: direction).to_f
    end

    def initialize(rationals: [], direction:)
      @rationals = rationals
      @direction = direction
    end

    def to_f
      return nil if @rationals.nil? || @rationals.empty?

      degrees = @rationals[0] || 0
      minutes = @rationals[1] || 0
      seconds = @rationals[2] || 0

      sign = 1
      sign = -1 if ["W", "S"].include?(@direction)
      sign * (degrees + (minutes / 60.0) + (seconds / 3600.0))
    end
  end
end