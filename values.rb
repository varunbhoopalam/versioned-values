#!/usr/bin/ruby

class Values
  ##
  # value_principle_hashes is expecting an array where the members are a hash like so
  # {principle: string, value: string, index: int}
  def initialize(value_principle_hashes)
    @entries = value_principle_hashes
  end 

  def update_value(principle, new_value)
    for entry in @entries 
      if entry["principle"].strip.downcase == principle.strip.downcase
        entry["value"] = new_value
      end
    end
  end
  
  def print
    for entry in @entries
      puts("#{entry["index"]}. Principle: #{entry["principle"]} | Value: #{entry["value"]}\n")
    end
  end

  def get_principles
    return @entries.map { |e| e["principle"] }
  end
  
  def encode
    return {principles: @entries}.to_json
  end

  def self.decode(file_content)
    return Values.new(JSON.parse(file_content)["principles"])
  end
end
