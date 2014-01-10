require 'colorize'

# REV: I actually prefer your implementation of the moves to mine,
# yours is cleaner
WHITE_MOVES = [[-1,-1], [-1, 1]]
RED_MOVES = [[ 1,-1], [ 1, 1]]
KING_MOVES = WHITE_MOVES + RED_MOVES

class Piece
  attr_accessor :move_dirs, :pos, :board, :color, :kinged
  attr_reader :token



  # REV: lining these variables up would look cool,
  # not an issue at all though
  def initialize(pos, board, color, kinged = false)
    @pos = pos
    @board = board
    @color = color
    @token = token
    @kinged = kinged
  end

  def token
    if kinged == false
      token = :o
    else
      token = :O
    end
  end

  def move_dirs
    if kinged == true # REV: you can omit 'true' if you want
      KING_MOVES
    elsif color == :r
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
    puts "slide!"
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
    @board[move_end] = @board[start_pos]
    @board[move_end].pos = move_end
    @board[start_pos] = nil
    @board[middle_pos] = nil
    puts "jump!"
  end

  def can_jump?(move_end)
    # return true if move_end is empty
    # and if the piece it is jumping is not the same color
    middle_pos = [((move_end[0]+pos[0])/2), ((move_end[1]+pos[1])/2)]
    dir = [middle_pos[0] - pos[0], middle_pos[1] - pos[1]]


    # REV: multiple lines
    if @board[move_end].nil? && @board[middle_pos] && move_dirs.include?(dir) && @board[middle_pos].color != color
      true
    else
      false
    end
  end

  def perform_moves(move_sequence)
    # First checks valid_move_seq?, THEN
    # either calls perform_moves!
    # OR raises an InvalidMoveError.
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
      maybe_promote
    else
      # raise InvalidMoveError
      raise "invalid move, bro!"
    end
    nil # REV: <- nice
  end

  def perform_moves!(move_sequence)
    # should not bother to try to restore the
    # original Board state if the move sequence fails.
    if move_sequence.count == 1
      if perform_slide(move_sequence[0]) == false
        if perform_jump(move_sequence[0]) == false
          raise "what?!?!?!?"
          return false
        else
          perform_jump(move_sequence[0])
        end
      else
        perform_slide(move_sequence[0])
      end
    else
      move_sequence.each do |move|
        p pos # REV: still debugging :)
        p move
        if perform_jump(move) == false
          return false
          puts "dat don't d'work!"
        else
          perform_jump(move)
        end
      end
    end

    true
  end

  def valid_move_seq?(move_sequence)
    #This will probably require begin/rescue/else
    #dup the board and pieces
    dup_board = @board.dup
    dup_board.board.each_index do |i|
      dup_board.board.each_index do |j|
        if dup_board[[i,j]]
          dup_board[[i,j]] = dup_board[[i,j]].dup(dup_board)
        end
      end
    end

    #check if moves are valid in sequence on duped board
    begin
      return false if dup_board[pos].perform_moves!(move_sequence) == false
    rescue
      puts "error!"
    end
    true
  end

  def dup(board)
    self.class.new(@pos, board, @color, @kinged)
  end

  def maybe_promote
    #check if piece is on other side
    #if so, give it KING_MOVES yo!
    if color == :r && pos[0] == 7
      @board[pos].kinged = true
      puts "kingz0red!"
      return true
    elsif color == :w && pos[0] == 0
      @board[pos].kinged = true
      puts "kingz0red!"
      return true
    end

    false
  end
end