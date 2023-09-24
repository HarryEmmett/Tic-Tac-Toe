require './player'
require './board'

# Game classs
class Game
  def init_game
    puts "Playing X's & 0's"
    p1 = create_player(1)
    p2 = create_player(2, p1.selection)
    board = Board.new
    p "Lets play: #{p1.name} (#{p1.selection}) vs #{p2.name} (#{p2.selection})"
    playing_game(p1, p2, board)
  end

  private

  def playing_game(ply1, ply2, board)
    playing = true
    current_player = nil
    while playing
      board.print_board

      current_player = switch_player(current_player, ply1, ply2)
      selection = player_turn(current_player.name, current_player.selection, board.create_board.flatten)

      board.update_board(selection, current_player.selection)

      playing = false if board.game_end
    end
    game_over(board)
  end

  def switch_player(player, ply1, ply2)
    if !player
      ply1
    else
      player == ply1 ? ply2 : ply1
    end
  end

  def game_over(board)
    p board.final_result
    board.print_board(game_end: true)
    reset_game
  end

  def reset_game
    puts 'Play again? (Y/ N)'
    restart = get_input('y', 'n')
    restart == 'y' ? init_game : (puts 'Thanks for playing!')
  end

  def get_input(inp_a, inp_b)
    input = gets.chomp
    return input if input == inp_a || input == inp_b

    puts "Incorrect entry enter #{inp_a} or #{inp_b}"
    get_input(inp_a, inp_b)
  end

  def get_selection(player)
    puts "Enter #{player}\'s selection (X / O)"
    selection = get_input('x', 'o')
    Player.new(player, selection.downcase)
  end

  def create_player(player_num, prev_player_selection = nil)
    puts "Enter player #{player_num}\'s name"
    player_name = gets.chomp
    if prev_player_selection
      prev_player_selection.downcase == 'x' ? Player.new(player_name, 'o') : Player.new(player_name, 'x')
    else
      get_selection(player_name)
    end
  end

  def check_valid_input(player, selection, board, valid_input)
    if board[valid_input - 1] == 'x' || board[valid_input - 1] == 'o'
      puts 'Move already done'
      player_turn(player, selection, board)
    else
      valid_input - 1
    end
  end

  def input_int
    input = gets.chomp
    # begin
    Integer(input)
    # rescue StandardError
    #   false
    # end
  end

  def player_turn(player, selection, board)
    puts "Player #{player}\'s turn (#{selection})"
    valid_input = input_int
    if !!valid_input && valid_input - 1 && (valid_input - 1).between?(0, 8)
      check_valid_input(p, selection, board, valid_input)
    else
      puts 'Enter a number between 1-9'
      player_turn(p, selection, board)
    end
  end
end
