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
    @file_data = {}

    begin
      File.foreach(File.expand_path('../../' + file_name, File.dirname(__FILE__))) do |line|
      end
    rescue StandardError => e
      "File not processable: #{e}"
    end
  end
end
