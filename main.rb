#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'
require 'json'

module Get
  
  def self.get_latest
    directories = Dir.children(".values")
    direc_hash = directories.map {|d| {directory: d, version: get_version_from_directory(d)} }
    latest_version = direc_hash.max_by{ |h| h[:version]}
    pretty_print(File.read(".values/#{latest_version[:directory]}/values.json"), latest_version[:version])
  end

  private_class_method def self.get_version_from_directory(directory_name)
    directory_name_w_replace = directory_name.sub('-', '.')
    return directory_name_w_replace.to_f
  end

  private_class_method def self.parse(json_string)
    return JSON.parse(json_string)["principles"]
  end

  private_class_method def self.pretty_print(json_string, version)
    hashes = parse(json_string)
    puts("\nValue Hierarchy Version: #{version}\n")
    for hash in hashes
      puts("#{hash["index"]}. Principle: #{hash["principle"]} | Value: #{hash["value"]}\n")
    end
  end

end


if __FILE__ == $0
  if not Dir.exists?(".values/1-0")
    Init.init
  else
    Get.get_latest
  end
end