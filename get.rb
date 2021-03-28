#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'versioned_values'

module Get
  def self.get_latest
    return get_all_versions.max_by{ |value| value.get_version.get_comparable_version }
  end
  
  def self.get_all
    return get_all_versions.sort_by { |value| value.get_version.get_comparable_version }
  end
  
  def self.get_version_list
    return Dir.children(".values")
  end
  
  def self.print_version(version)
    if get_version_list.any? { |v| v == version }
      v = VersionedValue.new(version)
      v.get_version.print_version
      v.get_values.print
    else
      puts("Could not find version: #{version}")
      puts("Please supply version in this format '1-0'")
    end
  end
  
  private_class_method def self.get_all_versions
    return get_version_list.map { |d| VersionedValue.new(d) }
  end
  

end