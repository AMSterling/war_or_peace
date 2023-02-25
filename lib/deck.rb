class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index].rank unless cards[index].nil?
  end

  def high_ranking_cards
    cards.select { |card| card.rank > 10 }
  end

  def percent_high_ranking
    (high_ranking_cards.count.to_f /  cards.count.to_f * 100).round(2)
  end

  def remove_card
    # cards.delete_if { |i| i == card }
    cards.shift
  end

  def add_card(card)
    cards.append(card)
  end
end
