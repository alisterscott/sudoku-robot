class Sudoku::Solver

  attr_reader :board, :moves

  def initialize board_string
    @moves = []
    @board = Sudoku::Board.new board_string
    known_values = @board.known_values

    while (not solved?) and (known_values.count > 0)
      @moves += @board.set_known_values
      known_values = @board.known_values
    end
  end

  def solved?
    @board.solved?
  end

end