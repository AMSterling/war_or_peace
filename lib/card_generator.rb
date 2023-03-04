class CardGenerator
  def initialize(filename)
    @filename = filename
  end

  def cards
    card_array = File.read(@filename).split("\n")

    card_array.map do |attrs|
      attrs_array = attrs.split(", ")
      rank = attrs_array[0]
      suit = attrs_array[1].downcase.to_sym
      value = attrs_array[2]
      Card.new(suit, value, rank)
    end
  end
end
