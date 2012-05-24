class Sudoku::Board
  include Enumerable
  include Sudoku

  ROW_COUNT = 9
  COL_COUNT = 9
  GROUPS_COUNT = 9
  attr_reader :cells, :groups
  #attr_reader :row_count, :col_count

  def initialize grid
    @cells = []
    grid = string_to_grid(grid) unless grid.kind_of? Array
    grid.each_with_index do |row, row_index|
      raise "invalid board grid, should be 9 x 9 '#{grid}'" unless row.length == ROW_COUNT and grid.length == COL_COUNT
      row.each_with_index do |cell, col_index|
        @cells << Sudoku::Cell.new(row_index, col_index, cell)
      end
    end
    # Create groups for easy accessibility
    @groups = []
    GROUPS_COUNT.times do |index|
      @groups << @cells.select{ |cell| cell.group == index }
    end
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end
end