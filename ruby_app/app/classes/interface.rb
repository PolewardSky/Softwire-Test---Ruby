# frozen_string_literal: true

require './app/classes/parse_file.rb'

ARGV.each do |file_name|
  file = ParseFile.new(file_name: file_name)
  file.load_file

  layout = 100.times.map{|x|(1..50).to_a}
  cinema = Cinema.new(layout: layout)

  

end

puts 'Processing complete'
