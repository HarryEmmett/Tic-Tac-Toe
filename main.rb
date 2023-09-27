# frozen_string_literal: true

require './game'
require './game_setup'
require './board'
require './computer'
require './player'

# game = Game.new
# game.init_game

computer = Computer.new('hard')
computer.play_computer(%w[o x o 3 4 5 x x o])
# o x o

# o x x