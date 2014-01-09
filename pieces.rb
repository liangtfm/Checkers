MOVES = [[-1,-1], [-1, 1],
         [ 1,-1], [ 1, 1]]

class Piece
  attr_accessor :move_dirs, :pos, :board, :color
  attr_reader :token

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
    @token = :O
  end

  def move_dirs
    MOVES
  end

  def perform_slide

  end

  def perform_jump

  end

  # def can_jump?(move_end)
  #   # return true if move_end is empty
  #   # and if the piece it is jumping is not the same color
  #   if @board[move_end].nil? && @board
  #     true
  #   end
  #   false
  # end

  def perform_moves
    # First checks valid_move_seq?, THEN
    # either calls perform_moves!
    # OR raises an InvalidMoveError.
  end

  def perform_moves!(move_sequence)
    #  should not bother to try to restore the
    # original Board state if the move sequence fails.

  end

  def valid_move_seq?
    #This will probably require begin/rescue/else
    #dup the board and pieces
    perform(moves!)
  end

  def dup(board)
    self.class.new(@pos, board, @color)
  end

end