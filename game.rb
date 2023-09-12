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

    playing = true
    while playing
      p board.create_board

      # GET CURRENT PLAYER

      selection = player_turn(1, 'x')
      return playing = false if selection == 'Game Over'

      board.update_board(selection, p1.selection)
      p board.create_board

      # CREATE GAME BOARD
      # MAKE A MOVE
      # CHECK IF WINNER

      # puts 'CURRENT SCORE'
      # puts 'WINNER MESSAGE'
    end
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
    puts "Enter player#{p}\'s selection (X / O)"
    selection = get_input('x', 'o')
    Player.new(player, selection.downcase)
  end

  private def create_player(playerNum, prev_player_selection = nil)
    puts "Enter player#{playerNum}\'s name"
    player_name = gets.chomp
    if prev_player_selection
      prev_player_selection.downcase == 'x' ? Player.new(player_name, 'o') : Player.new(player_name, 'x')
    else
      get_selection(playerNum)
    end
  end

  private def player_turn(p, selection)
    puts "Player#{p}\'s turn (#{selection})"
    input = gets.chomp
    valid_input = begin
      Integer(input)
    rescue StandardError
      false
    end
    if valid_input && valid_input.between?(0, 8)
      valid_input
    else
      puts 'Enter a number between 0-8'
      player_turn(p, selection)
    end
  end
end
