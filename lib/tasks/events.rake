require "date"

namespace :events do
  require_relative "events_fixtures"
  users = EventsFixtures::USERS
  asset_types = EventsFixtures::ASSET_TYPES
  context_id = EventsFixtures::ASSET_TYPES

  desc "Generate random events into canvas_events table"
  task gen_rand: :environment do
    main(users, asset_types, context_id)
  end
end

=begin
  Todo:
    [] Ask user for date range

  Todo Later (nice to haves):
    [] Ask user for event type
    [] Ask the user for context_id
    [] Ask the user for a list of students
    [] Ask the user for a list of students
    [] Give the user an option to pull student data from course id
=end

def main(users, asset_types, context_id)
  prompt_user :delete_events
  num_records = prompt_user :num_records
  chunk_size = prompt_user :chunk_size
  start_date = prompt_user :start_date
  end_date = prompt_user :end_date

  create_rand_event_records(
    num_records,
    users,
    asset_types,
    context_id,
    chunk_size,
    start_date,
    end_date,
  )
end

def prompt_user option
  case option
  when :delete_events
    puts "Would you like to delete all previous events? [yes/no]"
    user_choice = STDIN.gets.chomp

    until ["yes", "no"].include?(user_choice)
      puts "Invalid option: \"#{user_choice}\" - please input yes or no"
      user_choice = STDIN.gets.chomp
    end

    unless user_choice == "no"
      puts "Deleting all records from canvas_events table"
      CanvasEvent.delete_all
    end

  when :num_records
    puts "How many event records would you like to create?"
    num_records = STDIN.gets.chomp.to_i

    until num_records > 0
      puts "Please input a number greater than 0"
      num_records = STDIN.gets.chomp.to_i
    end

  when :chunk_size
    puts "How many random events do you want to assign to a student per iteration?"
    puts "[chunk_size/info]"
    user_choice = STDIN.gets.chomp

    if user_choice == "info"
      puts "For example if you would like to create 1000 records the number"
      puts "you input here (n) will be used to assign a student 1..n random"
      puts "live events. Let\'s say rand(n = 50) + 1 = 50. 50.times random records"
      puts "will be created for a random student. That\'s one iteration. The"
      puts "remaining records will now be 950."
      puts "Make sense? Ok, go ahead and enter a number"
      user_choice = STDIN.gets.chomp
    end

    until user_choice.to_i > 0
      puts "Please input a number greater than 0"
      user_choice = STDIN.gets.chomp.to_i
    end

  when :start_date
    puts "Please specify a start date [yyyy-mm-dd]"
    user_input = STDIN.gets.chomp
    start_date = nil

    until start_date.class.to_s == "DateTime"
      begin
        start_date = user_input.to_datetime
      rescue ArgumentError
        puts "Sorry, that format can\'t be read. Please input a start date using yyyy-mm-dd"
        user_input = STDIN.gets.chomp
      end
    end

    start_date

  when :end_date
    puts "Please specify an end date [yyyy-mm-dd]"
    user_input = STDIN.gets.chomp
    end_date = nil

    until end_date.class.to_s == "DateTime"
      begin
        end_date = user_input.to_datetime
      rescue ArgumentError
        puts "Sorry, that format can\'t be read. Please input a end date using yyyy-mm-dd"
        user_input = STDIN.gets.chomp
      end
    end

    end_date
  end
end

def time_rand(from = 0.0, to = DateTime.now.utc.iso8601)
  Time.at(from + rand * (to.to_f - from.to_f))
end

def create_rand_event_records(
  num_records,
  users,
  asset_types, # ASSET_TYPES[asset_type] => asset_subtype
  context_id,
  chunk_size # How many random possible events on an iteration are assigned to a user
)
  puts "Creating #{num_records} events"
  total = num_records

  until total == 0
    chunk = rand(chunk_size) + 1

    if total - chunk < 0
      chunk = total - chunk + chunk
    end

    chunk.times do
      rand_user = users.sample
      rand_asset_type = asset_types.keys.sample
      rand_asset_subtype = asset_types[rand_asset_type].sample
      CanvasEvent.create(
        event_type: "asset_accessed",
        asset_name: nil,
        asset_type: rand_asset_type,
        asset_subtype: rand_asset_subtype,
        user_id: rand_user[:id],
        context_id: context_id, # course id for now
        event_time: "2019-11-01T00:09:07.276Z",
      )
    end

    total -= chunk
  end

  puts "Finished creating #{num_records} events"
end
