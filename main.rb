#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'init'
require 'get'

class UpdateSession
      
  def initialize(principles, previous_version)
    @principles = principles
    @previous_version = previous_version
    @updated = false
  end

  def value
    for hash in @principles
      puts("#{hash["index"]}. Principle: #{hash["principle"]} | Value: #{hash["value"]}\n")
    end
    puts("Type in the principle that you want to change the interpretation of (value). Or type back to go back.")
    valid_options = @principles.map { |p| p["principle"]}
    while input = Readline.readline("> ", true)
      break if input.strip.downcase == "back"
      break if valid_options.any? { |option| option.strip.downcase == input.strip.downcase }
      puts("I didn't recognize that.")
      puts("Type in the principle that you want to change the interpretation of (value). Or type back to go back.")
    end
    
    sanetized_input = input.strip.downcase
    
    if sanetized_input == "back"
      puts("Going back to update flow without making a value change")
    else 

      puts("Type in your new interpretation of your principle: #{input}")
      while new_value = Readline.readline("> ", true)
        break if new_value.length > 0
      end

      for hash in @principles 

        if hash["principle"].strip.downcase == sanetized_input
          hash["value"] = new_value
        end

        @updated = true
      
      end
  end

  def finish 
    if @updated == false
      puts("No updates! Signing off")
    else 
      puts("Here is your new hierarchy")
      for hash in @principles
        puts("#{hash["index"]}. Principle: #{hash["principle"]} | Value: #{hash["value"]}\n")
      end

      puts("Can you give some notes on what has changed and why?")
      while release_notes = Readline.readline("> ", true)
        break if release_notes.length > 0
      end

      vers = @previous_version + 0.1
      version = vers.truncate(1)
      version_string = version.to_s.sub(".","-")
      version_directory = ".values/#{version_string}"

      FileUtils.mkdir_p(version_directory)
      tempHash = {principles: @principles}
      File.open("#{version_directory}/values.json","w") do |f|
        f.write(tempHash.to_json)
      end
      File.open("#{version_directory}/release-notes.txt","w") do |f|
        f.write(release_notes)
      end
      metadata = { timestamp: Time.now.to_i, version: version}
      File.open("#{version_directory}/metadata.json","w") do |f|
        f.write(metadata.to_json)
      end
    end
  end
  
  end 
end

module Update
  def self.update_flow
    puts("\nWelcome to the update flow. Here you can make changes to your value hierarchy and publish a new version!")
    puts("Coming soon you'll be able to re-order, add, and remove principles!")
    latest = Get.get_latest
    session = UpdateSession.new(latest[:principles], latest[:version])
    choose_update(session)
  end

  def self.choose_update(session)
    puts("\nvalue - update your interpretation of a principle")
    puts("Select an option by typing one of the following options")
    options = ["value", "finish"]
    puts(options.join(" | "))

    while input = Readline.readline("> ", true)
      break if options.any? { |option| option == input.strip.downcase }
    end

    case input.strip.downcase
    when "value"
      session.value
      choose_update(session)
    when "finish"
      puts(session.to_json)
      session.finish
    else
      "You gave me #{input} -- I have no idea what to do with that :)"  
      choose_update(session)
    end
  end
end

if __FILE__ == $0
  input_array = ARGV
  if not Dir.exists?(".values/1-0")
    Init.init
  elsif input_array.any? {|a| a == "-u"}
    Update.update_flow
  else
    Get.print_latest
  end
end