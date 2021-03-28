#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'readline'
require 'fileutils'
require 'json'
require 'date'
require 'writer'
require 'values'

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
      else
        FileUtils.remove_dir(".values")
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
    puts("\n Remaining Principles:")
    puts(principles_and_values.map {|pv| pv[:principle]}.join(" | "))
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
      puts(principles_and_values.map {|pv| pv[:principle]}.join(" | "))
    
    end
    return principle_and_value_list
  end
  
  def self.init
    return if cannot_initialize_directory
    principles = get_principles
    principles_and_values = add_values_to_principles(principles)
    values = Values.new(order_principles(principles_and_values))
    Writer.initial_write(values.encode)
  end
end