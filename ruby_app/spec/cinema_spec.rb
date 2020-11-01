# frozen_string_literal: true

require './app/classes/cinema.rb'

describe Cinema do
  let(:cinema_layout) { 100.times.map { |_x| (0..49).to_a } }
  let(:cinema) { Cinema.new(layout: cinema_layout) }
  let(:bookings) { ParseFile.new(file_name: 'app/files/sample_booking_requests.csv') }

  it 'creates object' do
    expect(subject).to have_attributes({})
  end

  it 'imports cinema layout' do
    expect(cinema.layout.first).to eq({ booked: false, column: 0, row: 0 })
  end

  it 'makes bookings successfully' do
    bookings.load_file

    cinema.make_bookings(booking_data: bookings.file_data)
    expect(cinema.layout.select { |x| x[:booked] == true }.size).to eq(1004)
    expect(cinema).to have_attributes({ booking_errors: 10 })
  end
end
