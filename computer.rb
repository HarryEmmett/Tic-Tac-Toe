# frozen_string_literal: true

# Computer class
class Computer
  def initialize(difficulty)
    @difficulty = difficulty
    @board = Board.new
    @current_board = nil
  end

  def play_computer(c)
    self.current_board = c
    difficulty == 'easy' ? easy_game(c) : hard_game(c)
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

    if winning(b, 'x')
      hash['score'] = 10
      return hash
    elsif winning(b, 'o')
      hash['score'] = -10
      return hash
    elsif available.length == 0
      hash['score'] = 0
      return hash
    end

    movesa = []

    available.each_with_index do |val, _inx|
      move = {}
      moveb = {}
      b[val.to_i] = player

      # if player == 'x'
      #   result = minimax(b, 'o') || nil
  
      #   return unless result

      #   move['index'] = val
      #   move['score'] = result['score']
      #   movesa << move
      #   b[val.to_i] = val
      # else
        result = minimax(b, player == "x" ? "o" : "x") || nil
        return unless result
        moveb['index'] = val
        moveb['score'] = result['score']
        movesa << moveb
        b[val.to_i] = val
  
      # end

    end
    p movesa

    nil
    # moves.push(win)
  end

  def easy_game(b)
    available = empty_index(b)
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end

  def hard_game(b)
    # i = b.map do |x|
    #   if %w[x o].include?(x)
    #     x
    #   else
    #     (x.to_i - 1).to_s
    #   end
    # end

    p minimax(b)
    # p "Computer chooses #{test['index']}"
    # test['index'].to_i
  end
end

# available.each_with_index do |_val, index|
#   move = {}
#   move['index'] = b[available[index].to_i]

#   # p player
#   b[available[index].to_i] = player

#   if player == 'x'
#     result = minimax(b, 'o')
#     move['player'] = 'x'
#     move['score'] = if result && result['score']

#                       result['score']
#                     else

#                       0
#                       return
#                     end
#   else
#     result = minimax(b, 'x')
#     move['player'] = 'o'
#     # p result
#     move['score'] = if result && result['score']
#                       result['score']
#                     else
#                       0
#                       return
#                     end
#   end

#   b[available[index].to_i] = move['index']

#   moves.push(move)
# end
# p moves
# nil
# # p moves
# # best_move = nil
# # if player == 'x'
# #   best_score = -1000
# #   moves.each do |val|
# #     best_move = val if val['score'] != 0 && val['score'] > best_score
# #   end
# # else
# #   best_scoreb = 1000
# #   moves.each do |val|
# #     best_move = val if val['score'] != 0 && val['score'] < best_scoreb
# #   end
# # end
# # best_move['index']
# end

# for i in 0..available.length - 1 do

#   move = {}

#   move['index'] = b[available[i].to_i]

#   b[available[i].to_i] = player

#   if player == 'x'
#     result = minimax(b, 'o')
#     move['player'] = player
#     val = result['score']
#     move['score'] = result
#   else
#     result = minimax(b, 'x')
#     move['player'] = player
#     p result
#     val = result['score']
#     move['score'] = result
#   end

#   b[available[i].to_i] = move['index'].to_s

#   moves.push(move)
