require_relative 'pieces'
require_relative 'deep_dup'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
    make_board(:r, 0)
    make_board(:w, 5)
  end

  def make_board(color, i)
    # MAKE THIS BETTER!! >_<
    even = [0,2,4,6]
    odd = [1,3,5,7]

    if color == :r
      4.times do |j|
        row1 = [i,odd[j]]
        row2 = [i+1,even[j]]
        row3 = [i+2,odd[j]]
        self[row1] = Piece.new(row1, self, color)
        self[row2] = Piece.new(row2, self, color)
        self[row3] = Piece.new(row3, self, color)
      end
    else
      4.times do |j|
        row1 = [i,even[j]]
        row2 = [i+1,odd[j]]
        row3 = [i+2,even[j]]
        self[row1] = Piece.new(row1, self, color)
        self[row2] = Piece.new(row2, self, color)
        self[row3] = Piece.new(row3, self, color)
      end
    end
    nil
  end

  def draw_board
    @board.map do |subarr|
      subarr.map { |i| i.nil? ? :_ : i.token }
    end
  end

  def render
    render = draw_board
    render.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        k = [i,j]
        l = i + j
         color = l.even? ? :green : :blue
        if cell == :_
          print "   ".colorize(:background => color)
        elsif self[k].color == :w
          print " #{cell} ".colorize(:yellow).colorize(:background => color)
        else
          print " #{cell} ".colorize(:red).colorize(:background => color)
        end
      end
      print "\n"
    end
    nil
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, k)
    x, y = pos
    @board[x][y] = k
  end

  def dup
    new_board = Board.new
    new_board.board = self.board.deep_dup
    new_board
  end

end