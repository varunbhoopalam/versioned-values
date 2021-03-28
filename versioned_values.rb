#!/usr/bin/ruby
$LOAD_PATH << '.'
require "values"
require "version"

class VersionedValue

  ##
  # Pass a version_string
  def initialize(version_string)
    @version_string = version_string
  end 

  ##
  # Returns an instance of class Values
  def get_values
    value_file = File.read(".values/#{@version_string}/values.json")
    return Values.decode(value_file)
  end

  def get_version
    return Version.new(@version_string)
  end
end