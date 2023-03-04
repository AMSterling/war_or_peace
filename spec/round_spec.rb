require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/round'
require './lib/card_generator'

RSpec.describe Round do
  let(:filename) { 'cards.txt' }
  let(:card_generator) { CardGenerator.new(filename) }
  let(:card_deck) { card_generator.cards }
  let(:deck1) { Deck.new(card_deck[0..25]) }
  let(:deck2) { Deck.new(card_deck[26..51]) }
  let(:round) { Round.new(card_deck) }
  let(:player1) { Player.new('Megan', deck1) }
  let(:player2) { Player.new('Aurora', deck2) }
  let(:turn) { Turn.new(player1, player2) }

  it 'exists' do

    expect(round).to be_an_instance_of Round
    expect(card_generator).to be_an_instance_of CardGenerator
    expect(card_deck).to be_all Card
    expect(deck1).to be_an_instance_of Deck
    expect(deck1.cards).to be_all Card
    expect(deck2).to be_an_instance_of Deck
    expect(deck2.cards).to be_all Card
    expect(player1).to be_an_instance_of Player
    expect(player2).to be_an_instance_of Player
    expect(turn).to be_an_instance_of Turn
  end

  it 'has a 52 card deck' do

    expect(round.card_deck.count).to eq 52
  end

  describe 'basic turn' do
    let(:deck2) { Deck.new(card_deck[26..51].rotate) }

    it 'changes player card counts' do

      expect(turn.type).to eq(:basic)
      expect(player1.deck.cards.count).to eq 26
      expect(player2.deck.cards.count).to eq 26

      turn.pile_cards

      expect(player1.deck.cards.count).to eq 25
      expect(player2.deck.cards.count).to eq 25
      expect(turn.spoils_of_war.count).to eq 2

      turn.award_spoils(turn.winner)

      expect(player1.deck.cards.count).to eq 25
      expect(player2.deck.cards.count).to eq 27

      turn.pile_cards

      expect(player1.deck.cards.count).to eq 24
      expect(player2.deck.cards.count).to eq 26
      expect(turn.spoils_of_war.count).to eq 2

      turn.award_spoils(turn.winner)

      expect(player1.deck.cards.count).to eq 24
      expect(player2.deck.cards.count).to eq 28
    end
  end

  describe 'mutually assured destruction turn' do
    it 'removes 6 cards from play' do

      expect(turn.type).to eq(:mutually_assured_destruction)
      expect(player1.deck.cards.count).to eq 26
      expect(player2.deck.cards.count).to eq 26

      turn.pile_cards

      expect(turn.spoils_of_war).to eq []
      expect(player1.deck.cards.count).to eq 23
      expect(player2.deck.cards.count).to eq 23
    end
  end
end
