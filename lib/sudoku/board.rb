class Sudoku::Board
  include Enumerable

  attr_reader :row_count, :col_count

  def initialize board_grid
    @board_grid = board_grid
    @row_count = board_grid.length
    @col_count = board_grid.map(&:length).max
  end
end