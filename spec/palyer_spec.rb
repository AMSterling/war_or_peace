require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

RSpec.describe Player do
  let(:card1) { Card.new(:diamonds, 'Queen', 12) }
  let(:card2) { Card.new(:spades, '3', 3) }
  let(:card3) { Card.new(:hearts, 'Ace', 14) }
  let(:deck) { Deck.new([card1, card2, card3]) }
  let(:player) { Player.new('Clarisa', deck) }

  it 'exists' do

    expect(card1).to be_an_instance_of(Card)
    expect(card2).to be_an_instance_of(Card)
    expect(card3).to be_an_instance_of(Card)
    expect(deck).to be_an_instance_of(Deck)
    expect(player).to be_an_instance_of(Player)
  end

  it 'has readable attributes' do

    expect(player.name).to eq('Clarisa')
    expect(player.deck).to eq(deck)
  end

  it 'loses when deck is empty' do

    expect(player.has_lost?).to be false

    player.deck.remove_card

    expect(player.has_lost?).to be false

    player.deck.remove_card

    expect(player.has_lost?).to be false

    player.deck.remove_card

    expect(player.has_lost?).to be true
  end
end
