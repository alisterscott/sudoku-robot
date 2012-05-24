class Sudoku::Board
  include Enumerable
  include Sudoku

  ROW_COUNT = 9
  COL_COUNT = 9
  GROUPS_COUNT = 9
  attr_reader :cells, :groups, :rows
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
    generate_groups
    generate_rows
    generate_cols
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end

  private
  def generate_groups
    # Create groups for easy accessibility
    @groups = []
    GROUPS_COUNT.times do |index|
      @groups << @cells.select{ |cell| cell.group == index }
    end
  end

  def generate_rows
    # Create rows for easy accessibility
    @rows = []
    ROW_COUNT.times do |index|
      @rows << @cells.select{ |cell| cell.row == index }
    end
  end

  def generate_cols
    # Create cols for easy accessibility
    @cols = []
    COL_COUNT.times do |index|
      @cols << @cells.select{ |cell| cell.col == index }
    end
  end
end