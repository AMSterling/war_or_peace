require 'rspec'
require './lib/card'
require './lib/deck'

RSpec.describe Deck do
  let(:card1) { Card.new(:diamond, 'Queen', 12) }
  let(:card2) { Card.new(:spade, '3', 3) }
  let(:card3) { Card.new(:heart, 'Ace', 14) }
  let(:cards) { [card1, card2, card3] }
  let(:deck) { Deck.new(cards) }

  it 'exists' do

    expect(card1).to be_an_instance_of(Card)
    expect(card2).to be_an_instance_of(Card)
    expect(card3).to be_an_instance_of(Card)
    expect(deck).to be_an_instance_of(Deck)
  end

  it 'has an array of cards' do

    expect(deck.cards).to eq([card1, card2, card3])
  end

  it 'has ranking of cards at index positions' do

    expect(deck.rank_of_card_at(0)).to eq(12)
    expect(deck.rank_of_card_at(2)).to eq(14)
  end

  it 'ranks cards valued over 10 as high' do

    expect(deck.high_ranking_cards).to eq([card1, card3])
  end

  it 'measures percent of high ranking cards in deck' do

    expect(deck.percent_high_ranking).to eq(66.67)
  end

  it 'removes and adds cards to the deck' do
    card4 = Card.new(:club, '5', 5)

    deck.remove_card

    expect(deck.cards).to eq([card2, card3])
    expect(deck.high_ranking_cards).to eq([card3])
    expect(deck.percent_high_ranking).to eq(50.0)

    deck.add_card(card4)

    expect(deck.cards).to eq([card2, card3, card4])
    expect(deck.high_ranking_cards).to eq([card3])
    expect(deck.percent_high_ranking).to eq(33.33)
  end
end
