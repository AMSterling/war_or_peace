require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/round'

RSpec.describe Round do
  let(:round) { Round.new }

  it 'exists' do

    expect(round).to be_an_instance_of Round
  end
end
