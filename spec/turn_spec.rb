require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

RSpec.describe Turn do
  let(:card1) { Card.new(:hearts, 'Jack', 11) }
  let(:card2) { Card.new(:hearts, '10', 10) }
  let(:card3) { Card.new(:hearts, '9', 9) }
  let(:card4) { Card.new(:diamonds, 'Jack', 11) }
  let(:card5) { Card.new(:hearts, '8', 8) }
  let(:card6) { Card.new(:diamonds, 'Queen', 12) }
  let(:card7) { Card.new(:hearts, '3', 3) }
  let(:card8) { Card.new(:diamonds, '2', 2) }
  let(:player1) { Player.new('Megan', deck1) }
  let(:player2) { Player.new('Aurora', deck2) }
  let(:turn) { Turn.new(player1, player2) }

  context 'basic' do
    let(:deck1) { Deck.new([card1, card2, card5, card8]) }
    let(:deck2) { Deck.new([card3, card4, card6, card7]) }

    it 'exists' do

      expect(deck1).to be_an_instance_of Deck
      expect(deck1.cards).to be_all Card
      expect(deck2).to be_an_instance_of Deck
      expect(deck2.cards).to be_all Card
      expect(player1).to be_an_instance_of Player
      expect(player2).to be_an_instance_of Player
      expect(turn).to be_an_instance_of Turn
    end

    it 'has readable attributes' do

      expect(turn.player1).to eq(player1)
      expect(turn.player2).to eq(player2)
      expect(turn.spoils_of_war).to eq([])
    end

    it 'is a basic type of turn' do

      expect(turn.type).to eq(:basic)
    end

    it 'has a winner' do

      expect(turn.winner).to eq(player1)
    end

    it 'has a pile of cards' do
      turn.pile_cards

      expect(turn.spoils_of_war).to eq([card1, card3])
    end

    it 'awards the pile cards to the winner' do

      winner = turn.winner

      turn.pile_cards

      expect(turn.spoils_of_war).to eq([card1, card3])

      turn.award_spoils(winner)

      expect(player1.deck.cards).to match_array([card2, card5, card8, card1, card3])
      expect(player2.deck.cards).to eq([card4, card6, card7])
    end
  end

  context 'war' do
    let(:deck1) { Deck.new([card1, card2, card5, card8]) }
    let(:deck2) { Deck.new([card4, card3, card6, card7]) }

    it 'is a war type of turn' do

      expect(turn.type).to eq(:war)
    end

    it 'awards the pile cards to the winner' do

      winner = turn.winner

      turn.pile_cards

      expect(turn.spoils_of_war).to eq([card1, card4, card2, card3, card5, card6])

      turn.award_spoils(winner)

      expect(player1.deck.cards).to eq([card8])
      expect(player2.deck.cards).to match_array([card7, card1, card4, card2, card3, card5, card6])
    end
  end

  context 'mutually assured destruction' do
    let(:card6) { Card.new(:diamonds, '8', 8) }
    let(:deck1) { Deck.new([card1, card2, card5, card8]) }
    let(:deck2) { Deck.new([card4, card3, card6, card7]) }

    it 'is a mutually assured destruction type of turn' do

      expect(turn.type).to eq(:mutually_assured_destruction)
    end

    it 'awards the pile cards to the winner' do

      winner = turn.winner

      turn.pile_cards

      expect(turn.spoils_of_war).to eq([])

      turn.award_spoils(winner)

      expect(player1.deck.cards).to eq([card8])
      expect(player2.deck.cards).to eq([card7])
    end
  end
end
