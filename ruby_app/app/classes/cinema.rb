# frozen_string_literal: true

# Receive and parse file outputs
class Cinema
  require 'active_support/core_ext/object/try'
  attr_accessor :layout, :bookings, :booking_errors

  def initialize(layout: [])
    @layout = process_layout(layout)
    @booking_errors = 0
  end

  def make_bookings(booking_data: [])
    booking_data.each_with_index do |bd, _i|
      columns = @layout.select { |x| x[:row] == bd[:row_start_index] }
      raise StandardError unless validate_booking_data(bd, columns)

      columns = columns.select { |x| first_to_last_seat(bd[:first_seat], bd[:last_seat]).include?(x[:column]) }
      columns.each { |x| x[:booked] = true }
    rescue StandardError
      @booking_errors += 1
    end
  end

  private

  def process_layout(layout)
    layout.each_with_index.map { |x, i| x.map { |j| { row: i, column: j, booked: false } } }.flatten
  end

  def validate_booking_data(bdata, columns) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    first_seat = bdata[:first_seat]
    last_seat = bdata[:last_seat]
    row_start = bdata[:row_start_index]
    row_end = bdata[:row_last_index]

    first_to_last = first_to_last_seat(first_seat, last_seat)
    first_minus_one_seat = columns.select { |x| x[:column] == first_seat - 1 }.first.try(:[], :booked)
    first_minus_two_seat = columns.select { |x| x[:column] == first_seat - 2 }.first.try(:[], :booked)
    last_plus_one_seat = columns.select { |x| x[:column] == last_seat + 1 }.first.try(:[], :booked)
    last_plus_two_seat = columns.select { |x| x[:column] == last_seat + 2 }.first.try(:[], :booked)

    return false if row_start != row_end # Are seats on same row?
    return false if first_to_last.size > 5 # Are seats adjacent and <= 5 in total
    if columns.select { |x| first_to_last.include?(x[:column]) && x[:booked] == true }.size.positive?
      return false # All seats available?
    end
    if first_seat == 1 && first_minus_one_seat == false
      return false # block unbooked seat left end row
    end
    if first_minus_one_seat == false && first_minus_two_seat == true
      return false # block unbooked seat left
    end
    if last_seat == 48 && last_plus_one_seat == false
      return false # block unbooked seat right end row
    end
    if last_plus_one_seat == false && last_plus_two_seat == true
      return false # block unbooked seat right
    end

    true
  end

  def first_to_last_seat(start_s, end_s)
    (start_s..end_s).to_a
  end
end
