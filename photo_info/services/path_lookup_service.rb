module PhotoInfo
  class PathLookupService
    def self.where(path:, extensions: )
      pattern = "#{path}**/*.{#{extensions.join(",")}}"
      Dir.glob(pattern)
    end
  end
end