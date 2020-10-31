# frozen_string_literal: true

require './app/classes/cinema.rb'

describe Cinema do
  let(:cinema_layout) { [[1,2],[1,2],[1,2]] }
  let(:cinema) { Cinema.new(layout: cinema_layout) }

  it 'creates object' do
    expect(subject).to have_attributes({})
  end

  it 'imports cinema layout' do
    expect(cinema).to have_attributes({:layout => cinema_layout})
  end

end
