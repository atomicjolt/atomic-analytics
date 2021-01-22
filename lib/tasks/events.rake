namespace :events do
  require_relative "events_fixtures"
  users = EventsFixtures::USERS
  desc "Generate random events into canvas_events table"
  task gen_rand: :environment do
    main(users)
  end
end

def main(users)
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

  puts "How many event records would you like to create?"
  num_records = STDIN.gets.chomp.to_i

  until num_records > 0
    puts "Please input a number greater than 0"
    num_records = STDIN.gets.chomp.to_i
  end

  unless num_records / 10 > 1
    create_rand_event_records(num_records, users)
  end
end

def time_rand(from = 0.0, to = Time.now)
  Time.at(from + rand * (to.to_f - from.to_f))
end

def create_rand_event_records(num_records, users)
  puts "Creating #{num_records} events"
  num_records.times do
    rand_user = users.sample
    CanvasEvent.create(
      event_type: "asset_accessed",
      asset_name: "Sandbox",
      asset_type: "Course",
      asset_subtype: "syllabus",
      user_id: rand_user[:id],
      context_id: "1233424",
      event_time: "2019-11-01T00:09:07.276Z",
    )
  end

  puts "Finished creating #{num_records} events"
end
