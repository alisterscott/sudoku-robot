module Sudoku
  class Solver
    attr_reader :board, :moves

    def initialize board_string
      @moves = []
      @board_analyser = Sudoku::BoardAnalyser.new board_string
      known_values = @board_analyser.known_values

      while (not solved?) and (known_values.count > 0)
        @moves += @board_analyser.set_known_values
        known_values = @board_analyser.known_values
      end
    end

    def solved?
      @board_analyser.board.solved?
    end

  end
end