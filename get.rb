#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'versioned_values'

module Get
  def self.get_latest
    directories = Dir.children(".values")
    versioned_values = directories.map { |d| VersionedValue.new(d) }
    return versioned_values.max_by{ |value| value.get_version.get_comparable_version}
  end
end