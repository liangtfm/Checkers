WHITE_MOVES = [[-1,-1], [-1, 1]]
RED_MOVES = [[ 1,-1], [ 1, 1]]
KING_MOVES = WHITE_MOVES + RED_MOVES

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
    if color == :r
      RED_MOVES
    elsif color == :w
      WHITE_MOVES
    end
  end

  def perform_slide(move_end)
    # An illegal slide/jump should return false; else true.
    return false unless can_slide?(move_end)
    start_pos = pos
    @board[move_end] = @board[start_pos]
    @board[move_end].pos = move_end
    @board[start_pos] = nil
  end

  def can_slide?(move_end)
    dir = [move_end[0] - pos[0], move_end[1] - pos[1]]
    if @board[move_end].nil? && move_dirs.include?(dir)
      true
    else
      false
    end
  end

  def perform_jump(move_end)
    # perform_jump should remove the jumped piece from the Board.
    return false unless can_jump?(move_end)
    middle_pos = [(move_end[0]+pos[0])/2, (move_end[1]+pos[1])/2]
    start_pos = pos
    pos = move_end
    @board[move_end] = @board[start_pos]
    @board[start_pos] = nil
    @board[middle_pos] = nil
  end

  def can_jump?(move_end)
    # return true if move_end is empty
    # and if the piece it is jumping is not the same color
    middle_pos = [((move_end[0]+pos[0])/2), ((move_end[1]+pos[1])/2)]
    dir = [middle_pos[0] - pos[0], middle_pos[1] - pos[1]]
    if @board[move_end].nil? && @board[middle_pos] && move_dirs.include?(dir) && @board[middle_pos].color != self.color
      true
    else
      false
    end
  end

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

  def maybe_promote

  end

  def find_dir(x, y)
    dir = [(y[0] - x[0]), (y[1] - x[1])]
    len = [dir[0].abs, dir[1].abs].max
    dir[0] = (dir[0].to_f / len) unless len == 0
    dir[1] = (dir[1].to_f / len) unless len == 0
    [dir, len]
  end

end