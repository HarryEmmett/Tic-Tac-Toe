require './player'
require './board'

class Game
  def init_game
    puts "Playing X's & 0's"
    playing_game
  end

  private def playing_game
    board = Board.new
    game_board = board.create_board
    p1 = create_player(1)
    p2 = create_player(2, p1.selection)

    player_turn = p1
    playing = true
    p "Lets play: #{p1.name} (#{p1.selection}) vs #{p2.name} (#{p2.selection})"
    while playing
      p board.create_board[0]
      p board.create_board[1]
      p board.create_board[2]

      currentPlayer = player_turn
      selection = player_turn(currentPlayer.name, currentPlayer.selection)
      playing = false if board.update_board(selection, currentPlayer.selection) == 'Game Over'

      board.update_board(selection, currentPlayer.selection)

      player_turn = currentPlayer == p1 ? p2 : p1

      # CHECK IF WINNER

      # puts 'CURRENT SCORE'
      # puts 'WINNER MESSAGE'
    end
    p 'GAME OVER'
    p board.create_board
    reset_game
  end

  private def reset_game
    puts 'Play again? (Y/ N)'
    restart = get_input('y', 'n')
    restart === 'y' ? init_game : (puts 'Thanks for playing!')
  end

  private def get_input(inp_a, inp_b)
    input = gets.chomp
    return input if input == inp_a || input == inp_b

    puts "Incorrect entry enter #{inp_a} or #{inp_b}"
    get_input(inp_a, inp_b)
  end

  private def get_selection(player)
    puts "Enter #{player}\'s selection (X / O)"
    selection = get_input('x', 'o')
    Player.new(player, selection.downcase)
  end

  private def create_player(player_num, prev_player_selection = nil)
    puts "Enter player #{player_num}\'s name"
    player_name = gets.chomp
    if prev_player_selection
      prev_player_selection.downcase == 'x' ? Player.new(player_name, 'o') : Player.new(player_name, 'x')
    else
      get_selection(player_name)
    end
  end

  private def player_turn(p, selection)
    puts "Player #{p}\'s turn (#{selection})"
    input = gets.chomp
    valid_input = begin
      Integer(input)
    rescue StandardError
      false
    end
    if valid_input - 1 && (valid_input - 1).between?(0, 8)
      valid_input - 1
    else
      puts 'Enter a number between 1-9'
      player_turn(p, selection)
    end
  end
end
