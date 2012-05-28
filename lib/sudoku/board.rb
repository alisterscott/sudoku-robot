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
    create_groups_rows_and_cols
    set_possible_values
  end

  def each
    @cells.each do |cell|
      yield cell
    end
  end

  def set_possible_values
    set_possible_values_from @groups
    set_possible_values_from @rows
    set_possible_values_from @cols
    set_possible_values_where_value_is_unique_in_group
  end

  def set_possible_values_where_value_is_unique_in_group
    @groups.each do |group|
      group.each do |cell|
        cell.possible_values.each do |possible_value|
          if group.select {|c| c != cell}.select {|ce| ce.possible_values.include? possible_value}.count == 0
            cell.possible_values = Set.new [possible_value]
            next
          end
        end
      end
    end
  end


  def to_s
    string = ""
    @cells.each do |cell|
      string << "\n" if cell.col == 0
      string << cell.value << ' '
    end
    string
  end

  def known_values
    @cells.select {|cell| cell.possible_values.count == 1}
  end

  def set_known_values
    kvs = known_values
    kvs.each do |cell|
      cell.value = cell.possible_values.first
      cell.possible_values = []
    end
    set_possible_values_from @groups
    set_possible_values_from @rows
    set_possible_values_from @cols
    kvs
  end

  def unknown_cell_count
    @cells.select{|cell| cell.value == "_"}.count
  end

  def solved?
    unknown_cell_count == 0
  end

  private

  def create_groups_rows_and_cols
    # Create groups, rows and cols for easy accessibility
    @groups = []
    @rows = []
    @cols = []
    GROUPS_COUNT.times do |index|
      @groups << @cells.select{ |cell| cell.group == index }
    end
    ROW_COUNT.times do |index|
      @rows << @cells.select{ |cell| cell.row == index }
    end
    COL_COUNT.times do |index|
      @cols << @cells.select{ |cell| cell.col == index }
    end
  end

  def set_possible_values_from collection
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