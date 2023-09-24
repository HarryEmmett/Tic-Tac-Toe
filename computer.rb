# frozen_string_literal: true

# Computer class
class Computer
  attr_reader :difficulty

  def initialize(difficulty)
    @difficulty = difficulty
  end

  def computer_choice(board)
    @difficulty == 'easy' ? easy_selection(board) : hard_selection(board)
  end

  private

  def easy_selection(board)
    available = board.create_board.flatten.select { |num| num != 'x' && num != 'o' }
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end

  def hard_selection(_board)
    p 'HARD SELECTIOn'
  end
end
