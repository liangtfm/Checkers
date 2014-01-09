require_relative 'colorize'
require_relative 'pieces'
require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    color = :r
    puts "Let's play Checkers!"
  end

  def turn

  end

  def render
    render = @board.draw_board
  end

end