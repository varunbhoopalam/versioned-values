#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'versioned_values'

module Get
  def self.get_latest
    return get_all_versions.max_by{ |value| value.get_version.get_comparable_version }
  end
  def self.get_all_descending
    return get_all_versions.sort_by { |value| value.get_version.get_comparable_version }.reverse!
  end
  private_class_method def self.get_all_versions
    return Dir.children(".values").map { |d| VersionedValue.new(d) }
  end
end