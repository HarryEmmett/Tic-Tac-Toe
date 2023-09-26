# frozen_string_literal: true

# Computer class
class Computer
  attr_reader :difficulty, :board_numbers

  def initialize(difficulty)
    @difficulty = difficulty
    @board_numbers = nil
  end

  def computer_choice(board_numbers)
    @board_numbers = board_numbers
    @difficulty == 'easy' ? easy_selection : hard_selection
  end

  private

  def easy_selection
    available = board_numbers.select { |num| num != 'x' && num != 'o' }
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end

  def hard_selection
    p 'HARD SELECTIOn'
  end
end
