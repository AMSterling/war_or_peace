require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Round
  def initialize
    @player1 = Player.new('Felek', Deck.new(card_deck[0..25]))
    @player2 = Player.new('Mina', Deck.new(card_deck[26..51]))
    @turn = Turn.new(@player1, @player2)
  end

  def card_deck
    deck = []
    suits = %i[clubs diamonds hearts spades]
    ranks = {
      '2' => 2,
      '3' => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      '10' => 10,
      'Jack' => 11,
      'Queen' => 12,
      'King' => 13,
      'Ace' => 14
    }
    suits.flat_map do |suit|
      ranks.map { |rank, value| deck << Card.new(suit, value, rank) }
    end
    deck.shuffle
  end

  def intro
    puts '---------------------------------------------------------------------'
    puts "  Welcome to War! (or Peace) This game will be played with #{card_deck.count} cards."
    puts "  The players today are #{@player1.name} and #{@player2.name}"
    puts "  Type 'go' to start the game!"
    puts '---------------------------------------------------------------------'
    phrase = gets.chomp
    if phrase != 'go'
      intro
    else
      start
    end
  end

  def start
    counter = 0
    until @turn.player1.has_lost? || @turn.player2.has_lost? || counter  == 10_000
      turn = @turn
      counter += 1
      winner = turn.winner
      turn.pile_cards
      message(counter, winner, turn)
      winner?(counter, turn)
    end
  end

  def winner?(counter, turn)
    if turn.player1.has_lost?
       puts "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif turn.player2.has_lost?
       puts "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    elsif  counter == 10_000 || (turn.player1.has_lost? && turn.player2.has_lost?)
       puts '*~*~*~* Peace Declared! *~*~*~*'
    end
  end

  def message(counter, winner, turn)
    case turn.type
    when :mutually_assured_destruction
      puts "Turn #{counter} * Mutually Assured Destruction * 6 cards removed from play,
      #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    when :war
      turn.award_spoils(winner)
      puts "Turn #{counter} *~* WAR *~* - #{winner.name} won 6 cards,
      #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    else :basic
      turn.award_spoils(winner)
      puts "Turn #{counter}  #{winner.name} won 2 cards,
      #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    end
  end
end
