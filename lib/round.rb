require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/card_generator'

class Round
  attr_reader :card_deck

  def initialize(card_deck)
    @card_deck = card_deck.shuffle
    @player1 = Player.new('Megan', Deck.new(@card_deck[0..25]))
    @player2 = Player.new('Aurora', Deck.new(@card_deck[26..51]))
    @turn = Turn.new(@player1, @player2)
  end

  def intro
    puts '---------------------------------------------------------------------'
    puts "  Welcome to War! (or Peace) This game will be played with #{@card_deck.count} cards."
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
    turn = @turn
    until turn.player1.has_lost? || turn.player2.has_lost? || counter  == 10_000
      winner = turn.winner
      counter += 1
      play(counter, winner, turn)
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

  def play(counter, winner, turn)
    case turn.type
    when :mutually_assured_destruction
      turn.pile_cards
      puts "Turn #{counter} * Mutually Assured Destruction * 6 cards removed from play,
      #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    when :war
      turn.pile_cards
      puts "Turn #{counter} *~* WAR *~* - #{winner.name} won #{turn.spoils_of_war.count} cards,"
      turn.award_spoils(winner)
      puts "  #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    else :basic
      turn.pile_cards
      puts "Turn #{counter}  #{winner.name} won #{turn.spoils_of_war.count} cards,"
      turn.award_spoils(winner)
      puts "  #{@player1.name} #{@player1.deck.cards.count}  -  #{@player2.name} #{@player2.deck.cards.count}"
    end
  end
end
