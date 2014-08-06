require_relative 'gem_version'

module Dradis
  module API
    # Returns the version of the currently loaded API as a
    # <tt>Gem::Version</tt>.
    def self.version
      gem_version
    end
  end
end
