module PhotoInfo
  class ExifCoordinate
    def self.to_f(rationals: [], dir:)
      new(rationals: rationals, dir: dir).to_f
    end

    def initialize(rationals: [], dir:)
      @rationals = rationals
      @dir = dir
    end

    def to_f
      return nil if @rationals.nil? || @rationals.empty?

      degrees = @rationals[0] || 0
      minutes = @rationals[1] || 0
      seconds = @rationals[2] || 0

      sign = 1
      sign = -1 if ["W", "S"].include?(@dir)
      sign * (degrees + minutes/60 + seconds/3600).to_f
    end
  end
end