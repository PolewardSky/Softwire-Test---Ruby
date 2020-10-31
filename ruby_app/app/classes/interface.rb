# frozen_string_literal: true

require './app/classes/parse_file.rb'
require './app/classes/cinema.rb'

ARGV.each do |file_name|
  file = ParseFile.new(file_name: file_name)
  file.load_file

  layout = 100.times.map{|x|(1..50).to_a}
  cinema = Cinema.new(layout: layout)

  booking_report = cinema.make_bookings(booking_data: file.file_data)
  puts cinema.layout.inspect
end

puts 'Processing complete'
