# frozen_string_literal: true

require './app/classes/parse_file.rb'

describe ParseFile do
  let(:parse_file) { ParseFile.new(file_name: 'app/files/sample_booking_requests.csv') }
  let(:parse_invalid_file) { ParseFile.new(file_name: 'app/files/123123.csv') }

  it 'creates object' do
    expect(subject).to have_attributes({})
  end

  it 'takes a file name' do
    expect(parse_file.file_name).to eq('app/files/sample_booking_requests.csv')
  end

  it 'loads a file' do
    parse_file.load_file
    expect(parse_file.file_data).to_not eq(nil)
  end

  it 'loads a invalid file' do
    parse_invalid_file.load_file
    expect(parse_file.file_data).to eq(nil)
  end
end
