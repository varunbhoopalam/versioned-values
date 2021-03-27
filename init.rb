#!/usr/bin/ruby
require 'readline'
require 'fileutils'
require 'json'
require 'date'

module Init  
  private_class_method def self.cannot_initialize_directory
    if Dir.exists?(".values") == true
      puts("It looks like the ./values folder is already being used in this directory, can we overwrite it? Y to overwrite")
      while input = Readline.readline("> ", true)
        break
      end
      
      if input != "Y"
        puts("Will not overwrite existing ./values directory and exiting application")
        return true
      end
    
    end
    return false
  end
  
  private_class_method def self.parsed_unique_principles
    principles = []
    puts("Please provide principles in a list with commas in-between like so: Accountability, Empathy, Integrity, Joyfulness, Initiative")
    while input = Readline.readline("> ", true)
      principles = input.split(",")
      break if principles.length() > 0
      puts("I couldn't understand what you wrote")
      puts(input)
      puts("Please provide principles in a list with commas in-between like so: Accountability, Empathy, Integrity, Joyfulness, Initiative")
    end
    puts("\nWonderful principles!")
    result = principles.uniq.map { |p| p.strip }
    puts(result.join("\n"))
    return result
  
  end
  
  private_class_method def self.get_principles
    puts("\nLet's start with what your principles are!")
    puts("Principles are universal truths, typically nouns, that live at the center of our being.")
    puts("Examples of principles are Accountability, Empathy, Integrity, Joyfulness, and Initiative.")
    puts("Can you give a list of principles that are central to how you live?\n")
    return parsed_unique_principles
  end
  
  private_class_method def self.get_value_of_principle(principle)
    puts("\nWhat is your interpretation of this principle: #{principle}")
    while input = Readline.readline("> ", true)
      break if input.length > 0
    end
    puts("\nPrinciple: #{principle} - Value: #{input.strip}")
    return input.strip
  end
  
  private_class_method def self.add_values_to_principles(principles)
    puts("\nValues are personal, internal, arguable guiding tools that help us navigate a complex changing world and make decisions.")
    puts("Values are our interpetation of our principles.")
    puts("You cannot practice the principle 'Integrity', but you can practice the value of 'doing the right thing.'")
    return principles.map { |p|
      { principle: p, value: get_value_of_principle(p)}
    }
  end
  
  private_class_method def self.order_principles(principles_and_values)
    puts("\nNow it's time to turn the value list into a value hierarchy!")
    puts("Type the name of the most important principle until there are no principles left!\n")
    puts("Remaining Principles:")
    puts(principles_and_values.map {|pv| "#{pv[:principle]}\n"})
    principle_and_value_list = []
    i = 1
    while input = Readline.readline("> ", true)  
      maybePAndV = principles_and_values.select { |hash| hash[:principle].downcase == input.strip.downcase }
      
      if not maybePAndV.empty?
        hash = maybePAndV[0]
        hash[:index] = i
        principle_and_value_list.push(hash)
        principles_and_values = principles_and_values.select { |hash| hash[:principle].downcase != input.strip.downcase }
        i = i + 1
      end
      
      break if principles_and_values.empty?
  
      puts("Remaining Principles:")
      puts(principles_and_values.map {|pv| "#{pv[:principle]}\n"})
    
    end
    return principle_and_value_list
  end
  
  private_class_method def self.write_to_disk(principle_hashes)
    FileUtils.remove_dir(".values")
    FileUtils.mkdir_p(".values/1-0")
    tempHash = {principles: principle_hashes}
    File.open(".values/1-0/values.json","w") do |f|
      f.write(tempHash.to_json)
    end
    File.open(".values/1-0/release-notes.txt","w") do |f|
      f.write("First release!")
    end
    metadata = { timestamp: Time.now.to_i, version: "1.0"}
    File.open(".values/1-0/metadata.json","w") do |f|
      f.write(metadata.to_json)
    end
  end
  
  def self.init
    return if cannot_initialize_directory
    principles = get_principles
    principles_and_values = add_values_to_principles(principles)
    ordered_principles = order_principles(principles_and_values)
    write_to_disk(ordered_principles)
  end
end


# What is ruby convention for file structure and how/where to store modules and classes?

# One - Build with no previous version
class VersionedValuesInit
  # Init - (values)
  # Write to disk
end
# Two - Build with previous version

class VersionedValues
  # Init - (values, release_notes, version)
  # Write to disk
end

# Three - Read from disk
class VersionedValueFromDisk
  # Init - direc
  # Get-Release-notes
  # Get-Values
end

class Version
  
  ## 
  # version_string is expected to be a string in this format 1-0
  def initialize(version_string)
    version_array = version_string.split("-")
    @major = version_array.first.to_i
    @minor = version_array.second.to_i
  end 

  def get_version
    return "#{@major}-#{@minor}"

  def next_minor_version
    return Version.new("#{@major}-#{@minor+1}")

  def next_major_version
    return Version.new("#{@major+1}-#{@minor}")
    
end

class Values

  ##
  # value_principle_hashes is expecting an array where the members are a hash like so
  # {principle: string, value: string}
  def initialize(value_principle_hashes)
    
  end 
  # update (principle, value)
  # get
  # encode
end