require './player'

class Game
  def initialize; end

  def init_game
    puts "Playing X's & 0's"
    playing_game
  end

  private def playing_game
    playing = true
    while playing
      p1 = create_player(1)
      p2 = create_player(2, p1.selection)

      # CREATE GAME BOARD
      # MAKE A MOVE
      # CHECK IF WINNER

      puts 'CURRENT SCORE'
      puts 'WINNER MESSAGE'
      play_again = reset_game

      if play_again
        init_game
      else
        playing = false
      end
    end
  end

  private def get_input(inp_a, inp_b)
    input = gets.chomp
    if input == inp_a || input == inp_b
      input
    else
      puts "Incorrect entry enter #{inp_a} or #{inp_b}"
      get_input(inp_a, inp_b)
    end
  end

  private def get_selection(player)
    puts "Enter player#{p}\'s selection (X / O)"
    selection = get_input('x', 'o')
    Player.new(player, selection)
  end

  private def create_player(p, selection = nil)
    puts "Enter player#{p}\'s name"
    player = gets.chomp
    if selection
      selection.downcase == 'x' ? Player.new(player, 'o') : Player.new(player, 'x')
    else
      get_selection(player)
    end
  end

  private def reset_game
    puts 'Play again? (Y/ N)'
    restart = get_input('y', 'n')

    if restart.downcase == 'y'
      init_game
    else
      puts 'Thanks for playing'
      false
    end
  end
end
