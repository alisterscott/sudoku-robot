class Sudoku::Board
  include Enumerable
  include Sudoku

  ROW_COUNT = 9
  COL_COUNT = 9
  GROUPS_COUNT = 9
  attr_reader :cells, :groups, :rows, :cols

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

  def known_values
    @cells.select {|cell| cell.possible_values.count == 1}
  end

  private
  def generate_groups
    # Create groups for easy accessibility
    @groups = []
    GROUPS_COUNT.times do |index|
      @groups << @cells.select{ |cell| cell.group == index }
    end
    generate_possible_values_from @groups
  end

  def generate_rows
    # Create rows for easy accessibility
    @rows = []
    ROW_COUNT.times do |index|
      @rows << @cells.select{ |cell| cell.row == index }
    end
    generate_possible_values_from @rows
  end

  def generate_cols
    # Create cols for easy accessibility
    @cols = []
    COL_COUNT.times do |index|
      @cols << @cells.select{ |cell| cell.col == index }
    end
    generate_possible_values_from @cols
  end

  def generate_possible_values_from collection
    collection.each do |member|
      remove_own_value_from_others_possible_values member
    end
  end


   def remove_own_value_from_others_possible_values array_cells
    array_cells.each do |cell|
      if cell.value != "_"
        array_cells.select{|c| c != cell}.each {|c| c.possible_values -= [cell.value] }
      end
    end
  end

end