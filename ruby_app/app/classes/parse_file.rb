# frozen_string_literal: true

# Receive and parse file outputs
class ParseFile
  attr_accessor :file_name, :file_data

  def initialize(file_name: '')
    @file_name = file_name
  end

  def load_file
    parse_file
  end

  private

  def parse_file
    @file_data = []

    begin
      File.foreach(File.expand_path('../../' + file_name, File.dirname(__FILE__))) do |line|
        line_split = line.tr('()', '').split(',')
        row_split = line_split[1].split(":")
        column_split = line_split[2].split(":")

        data = { :id => line_split[0], :row_start_index => row_split[0], :first_seat => row_split[1], :row_last_index => column_split[0], :last_seat => column_split[1] }

        @file_data.push(data)
      end
    rescue StandardError => e
      "File not processable: #{e}"
    end

    @file_data
  end
end
