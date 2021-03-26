#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'

module Get
  
  def self.get_latest
    directories = Dir.children(".values")
    direc_hash = directories.map {|d| {directory: d, version: get_version_from_directory(d)} }
    foo = direc_hash.max_by{ |h| h[:version]}[:directory]
    pretty_print(File.read(".values/#{foo}/values.json"))
  end

  private_class_method def self.get_version_from_directory(directory_name)
    directory_name_w_replace = directory_name.sub('-', '.')
    return directory_name_w_replace.to_f
  end

  private_class_method def self.pretty_print(json_values)
    puts(json_values)
  end

end


if __FILE__ == $0
  if not Dir.exists?(".values/1-0")
    Init.init
  else
    Get.get_latest
  end
end