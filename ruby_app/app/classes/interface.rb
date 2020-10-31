# frozen_string_literal: true

require './app/classes/parse_file.rb'

ARGV.each do |file_name|
  file = ParseFile.new(file_name: file_name)
  file.load_file
  puts file.inspect
end

puts 'Processing complete'
