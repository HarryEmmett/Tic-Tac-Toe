# frozen_string_literal: true

# player class
class Player
  attr_reader :name, :selection

  def initialize(name, selection)
    @name = name
    @selection = selection
  end
end
