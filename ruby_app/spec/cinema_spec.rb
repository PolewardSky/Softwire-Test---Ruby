# frozen_string_literal: true

require './app/classes/cinema.rb'

describe Cinema do
  let(:cinema_layout) { [[1,2],[1,2],[1,2]] }
  let(:cinema_processed_layout) { [[1,2],[1,2],[1,2]] }
  let(:cinema) { Cinema.new(layout: cinema_layout) }

  it 'creates object' do
    expect(subject).to have_attributes({})
  end

  it 'imports cinema layout' do
    expect(cinema.layout.first).to eq([{:booked=>false, :column=>1, :row=>0}, {:booked=>false, :column=>2, :row=>0}])
  end

  it 'makes bookings' do
    cinema.make_bookings
    expect(cinema).to have_attributes({:booking_errors => 10})
  end

end
