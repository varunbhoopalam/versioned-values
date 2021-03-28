#!/usr/bin/ruby

module Writer

  def self.initial_write(encoded_values)
    write(encoded_values, "1-0", "First release!")
  end 

  def self.write(encoded_values, version_string, release_notes)
    directory_name = ".values/#{version_string}"
    FileUtils.mkdir_p(directory_name)
    write_to_disk("#{directory_name}/values.json", encoded_values)
    write_to_disk("#{directory_name}/release-notes.txt", release_notes)
    
    metadata = { timestamp: Time.now.to_i, version: "1.0"}.to_json
    write_to_disk("#{directory_name}/metadata.json", metadata)
  end

  private_class_method def self.write_to_disk(file_name, content)
    File.open(file_name,"w") do |f| f.write(content) end
  end

end 