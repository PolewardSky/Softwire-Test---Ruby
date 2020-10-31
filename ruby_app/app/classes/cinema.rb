# frozen_string_literal: true

# Receive and parse file outputs
class Cinema
  attr_accessor :layout, :bookings

  def initialize(layout: [])
    @layout = process_layout(layout)
  end

  def make_bookings(booking_data: [])
    booking_data.each do |bd|
      puts @layout[bd[:id].to_i]
    end
  end

  private

    def process_layout(layout)
      layout.each_with_index.map {|x, i| x.map {|j| {:row => i, :column => j, :booked => false} }}
    end
end
