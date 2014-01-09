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
      win?
      color == :r ? color = :w : color = :r
    end

    puts "#{color.upcase} loses!"
  end

  def win?
    remaining_pieces = @board.board.map {|row| row}
    remaining_pieces = remaining_pieces.flatten.compact
    remaining_pieces.all? { |piece| piece.color == color }
  end

  def turn
    begin
      # starting position
      puts "Which piece would you like to move? (ex. b6)"
      move_start = gets.chomp.downcase.split("")
      move_start = [KEY_MAP[move_start.last], move_start.first.ord - "a".ord]

      # end position
      puts "Where would you like to move it? (ex. a5)"
      move_end = gets.chomp.downcase.split("")
      move_end = [KEY_MAP[move_end.last], move_end.first.ord - "a".ord]

      # put end position into move_sequence
      @move_sequence << move_end

      # prompt for additional input (optional)
      puts "You can add multiple spots, just enter f when finished"
      until gets.chomp == "f"
        move_end = gets.chomp.downcase.split("")
        move_end = [KEY_MAP[move_end.last], move_end.first.ord - "a".ord]
        @move_sequence << move_end
        puts "Got it!"
        return
      end

      # if @board[move_start].color != color
      #   @move_sequence = []
      # end

      @board[move_start].perform_moves(@move_sequence)
      @move_sequence = []
    # rescue
    #   puts "That sequence was garbage. Try again!".colorize(:red)
    #   puts "Did you make sure you picked your own piece?".colorize(:red)
    #   render
    #   retry
    end

  end

  def render
    render = @board.render
  end

end