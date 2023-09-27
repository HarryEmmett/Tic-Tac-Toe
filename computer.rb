# frozen_string_literal: true

# Computer class
class Computer
  def initialize(difficulty)
    @difficulty = difficulty
    @board = Board.new
    @current_board = nil
  end

  def play_computer(current_board)
    self.current_board = current_board
    difficulty == 'easy' ? easy_game : hard_game
  end

  private

  attr_reader :difficulty
  attr_accessor :current_board, :board

  def empty_index(b)
    b.select { |num| num != 'x' && num != 'o' }
  end

  def winning(b, player)
    winning_combiniations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    winning_combiniations.any? do |val|
      return true if [b[val[0]], b[val[1]], b[val[2]]].uniq.length == 1 && b[val[0]] == player
    end
    false
  end

  def minimax(b, player = 'x')
    available = empty_index(b)
    hash = {}

    if available.empty?
      hash['score'] = 0
      return hash
    elsif winning(b, 'x')
      hash['score'] = 10
      return hash
    elsif winning(b, 'o')
      hash['score'] = -10
      return hash
    end

    moves = []

    for i in 0..available.length - 1 do

      move = {}

      move['index'] = b[available[i].to_i]

      b[available[i].to_i] = player

      if player == 'x'
        result = minimax(b, 'o')
        move['player'] = 'x'
        move['score'] = result['score'] if result && result['score']
      else
        result = minimax(b, 'x')
        move['player'] = 'o'
        move['score'] = result['score'] if result && result['score']
      end

      b[available[i].to_i] = move['index']

      moves.push(move)
    end
    best_move = nil
    if player == 'x'
      best_score = -100_000
      moves.each_with_index do |move, i|
        next unless move['score'] > best_score

        best_score = move['score']

        best_move = i
      end
    else
      best_score = 100_000
      moves.each_with_index do |move, i|
        p best_move
        next unless move['score'] < best_score

        best_score = move['score']

        best_move = i
      end
    end

    # p moves[best_move]

    moves[best_move]
  end

  def easy_game
    available = empty_index
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end

  def hard_game
    minimax(current_board)
  end
end
