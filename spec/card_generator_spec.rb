require './lib/card_generator'

RSpec.describe CardGenerator do
  let(:filename) { 'cards.txt' }
  let(:card_generator) { CardGenerator.new(filename) }

  it 'exists' do

    expect(card_generator).to be_an_instance_of CardGenerator
  end

  it 'generates a full 52 card deck' do

    expect(card_generator.cards).to be_an Array
    expect(card_generator.cards).to be_all Card
    expect(card_generator.cards.count).to eq 52
    card_generator.cards.each do |card|
      expect(card.suit).to be_a Symbol
      expect(card.suit).to eq(:clubs).or eq(:diamonds).or eq(:hearts).or eq(:spades)
      expect(card.value).to be_a String
      expect(card.value.to_i).to be_between(2, 14)
      expect(card.rank).to be_a String
    end
  end
end
