# REV: code looks good to me and is very readable.
#      a couple of minor subjective suggestions
#      that don't matter. Good job bro!

require 'colorize'
require_relative 'pieces'
require_relative 'board'

class Game

  KEY_MAP = {
    "1" => 7,
    "2" => 6,
    "3" => 5,
    "4" => 4,
    "5" => 3,
    "6" => 2,
    "7" => 1,
    "8" => 0
  }

  attr_accessor :board, :move_sequence, :color

  def initialize
    @board = Board.new
    @move_sequence = []
  end

  def play
    color = :r
    puts "Let's play Checkers!"

    loop do
      @board.render
      puts "it's #{color}'s turn!"
      turn
      break if win?
      color == :r ? color = :w : color = :r
    end

    puts "#{color.upcase} loses!"
  end

  def win?
    # win if the only pieces left on the board are the same color
    current_board = @board.board.map {|row| row}
    remaining_pieces = current_board.flatten.compact
    remaining_pieces.all? { |piece| piece.color == color }
  end

  def turn


      # get starting position
      puts "Which piece would you like to move? (ex. b6)"
      move_start = gets.chomp.downcase.split("")
      move_start = [KEY_MAP[move_start.last], move_start.first.ord - "a".ord]

      #get move(s)
      puts "Where would you like to move it? (ex. a5)"
      puts "You can add multiple spots, just enter f when finished"
      move_end = gets.chomp.downcase.split("")
      move_end = [KEY_MAP[move_end.last], move_end.first.ord - "a".ord]
      @move_sequence << move_end
      puts "Got it!"


      @board[move_start].perform_moves(@move_sequence)
      @move_sequence = []


      # if @board[move_start].color != color
      #   @move_sequence = []
      # end

      # @board[move_start].perform_moves(@move_sequence)
      # @move_sequence = []
    # rescue
    #   puts "That sequence was garbage. Try again!".colorize(:red)
    #   puts "Did you make sure you picked your own piece?".colorize(:red)
    #   render
    #   retry
    # end

  end


  # REV: I don't think you are calling this method from anywhere
  def render
    render = @board.render
  end

end