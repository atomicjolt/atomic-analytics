require "date"

namespace :events do
  require_relative "events_fixtures"
  USERS = EventsFixtures::USERS
  ASSET_TYPES = EventsFixtures::ASSET_TYPES
  CONTEXT_ID = EventsFixtures::CONTEXT_ID

  desc "Generate random events into canvas_events table"
  task :gen_rand, [:context_id, :users] => :environment do |_task, args|
    args.with_defaults(context_id: CONTEXT_ID, users: USERS)
    users, context_id = args.values_at(:users, :context_id)
    main(users, ASSET_TYPES, context_id)
  end
end

=begin
  Todo Later (nice to haves):
    [] Show percent complete bar to user
    [] Ask user for event type, or array of event types
    [X] Ask the user for context_id
    [X] Ask the user for a list of students
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

    num_records

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

    start_date.utc.iso8601

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

    end_date.utc.iso8601
  end
end

def time_rand(start_date, end_date)
  s = start_date.to_datetime.utc
  e = end_date.to_datetime.utc

  month_diff = e.month - s.month
  day_diff = e.day - s.day
  min_hour = 6
  max_hour = 24
  min_second = 1
  max_second = 60

  rand_month = 1 + rand(month_diff)
  rand_day = 1 + rand(day_diff)
  rand_hour = 1 + (max_hour - min_hour)
  rand_second = 1 + (max_second - min_second)

  s = s + rand_month.month + rand_day.day + rand_hour.hour + rand_second.second

  if s > e
    e = (e + rand_hour.hour + rand_second.second).iso8601
  else
    s.iso8601
  end
end

def create_rand_event_records(
  num_records,
  users,
  asset_types, # ASSET_TYPES[asset_type] => asset_subtype
  context_id,
  chunk_size, # How many random possible events on an iteration are assigned to a user
  start_date,
  end_date
)
  puts "Creating #{num_records} events"
  total = num_records

  until total == 0
    chunk = (rand(chunk_size) + 1).floor

    if total - chunk < 0
      chunk = total - chunk + chunk
    end

    chunk.times do
      rand_user = users.sample
      rand_asset_type = asset_types.keys.sample
      rand_asset_subtype = asset_types[rand_asset_type].sample
      rand_time = time_rand(start_date, end_date)
      CanvasEvent.create(
        event_type: "asset_accessed",
        asset_name: nil,
        asset_type: rand_asset_type,
        asset_subtype: rand_asset_subtype,
        user_id: rand_user[:id],
        context_id: context_id, # course id for now
        event_time: rand_time,
      )
    end

    total -= chunk
  end

  puts "Finished creating #{num_records} events"
end
