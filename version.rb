#!/usr/bin/ruby

class Version
  
  ## 
  # version_string is expected to be a string in this format 1-0
  def initialize(version_string)
    version_array = version_string.split("-")
    @major = version_array[0].to_i
    @minor = version_array[1].to_i
  end 

  def get_version
    return "#{@major}-#{@minor}"
  end
  
  def print_version
    puts("\nValue Hierarchy Version: #{get_version}\n")
  end
  
  def get_comparable_version
    return "#{@major}.#{@minor}".to_f
  end

  def next_minor_version
    return Version.new("#{@major}-#{@minor+1}")
  end

  def next_major_version
    return Version.new("#{@major+1}-#{@minor}")
  end
    
end