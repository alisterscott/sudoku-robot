class Sudoku::BoardAnalyser
  include Sudoku

  attr_reader :board

  def initialize board
    @board = board
  end

  def possible_values_for row, col
    return 1,2,3,4,5,6,7,8,9
  end
end