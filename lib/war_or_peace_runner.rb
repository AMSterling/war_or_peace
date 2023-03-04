require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/round'
require './lib/card_generator'

filename = 'cards.txt'
card_deck = CardGenerator.new(filename).cards
round = Round.new(card_deck)
round.intro
