class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if (player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)) && (player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2))
      :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      :war
    else player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    end
  end

  def winner
    case type
    when :war
      if (player1.deck.cards.count >= 3 && player2.deck.cards.count < 3) ||
        (player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2))
        player1
      elsif (player2.deck.cards.count >= 3 && player1.deck.cards.count < 3) ||
        (player1.deck.rank_of_card_at(2) < player2.deck.rank_of_card_at(2))
        player2
      end
    when :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      elsif player1.deck.rank_of_card_at(0) < player2.deck.rank_of_card_at(0)
        player2
      end
    else
      if player2.deck.cards.count == 0 && player1.deck.cards.count > 0
        player1
      elsif player1.deck.cards.count == 0 && player2.deck.cards.count > 0
        player2
      end
    end
  end

  def pile_cards
    case type
    when :mutually_assured_destruction
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    when :war
      3.times do
        spoils_of_war << player1.deck.remove_card unless player1.deck.cards.empty?
        spoils_of_war << player2.deck.remove_card unless player2.deck.cards.empty?
      end
    else :basic
      spoils_of_war << player1.deck.remove_card
      spoils_of_war << player2.deck.remove_card
    end
  end

  def award_spoils(winner)
    spoils_of_war.each do |card|
      winner.deck.add_card(card)
    end
    @spoils_of_war = []
  end
end
