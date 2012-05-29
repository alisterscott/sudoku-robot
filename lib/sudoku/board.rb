module Sudoku
  class Board
    include Enumerable

    ROW_COUNT = 9
    COL_COUNT = 9
    GROUPS_COUNT = 9
    attr_accessor :cells, :groups, :rows, :cols

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
    end

    def each
      @cells.each do |cell|
        yield cell
      end
    end

    def cell_at x,y
      @rows[x][y]
    end

    def to_s
      string = ""
      @cells.each do |cell|
        string << "\n" if cell.col == 0
        string << cell.value << ' '
      end
      string
    end

    def group_neighbours_of_cell cell
      @groups[cell.group].select{|c| c != cell}
    end

    def row_neighbours_of_cell cell
      @rows[cell.row].select{|c| c != cell}
    end

    def col_neighbours_of_cell cell
     @cols[cell.col].select{|c| c != cell}
    end

    def unset_row_neighbours_of_cell cell
      row_neighbours_of_cell(cell).select{|c| c.value == "_"}
    end

    def unset_col_neighbours_of_cell cell
      col_neighbours_of_cell(cell).select{|c| c.value == "_"}
    end

    def unset_group_neighbours_of_cell cell
      group_neighbours_of_cell(cell).select{|c| c.value == "_"}
    end

    def unset_group_neighbours_in_same_row cell
      unset_group_neighbours_of_cell(cell).select{|c| c.row == cell.row}
    end

    def unset_group_neighbours_not_in_same_row cell
      unset_group_neighbours_of_cell(cell).select{|c| c.row != cell.row}
    end

    def unset_group_neighbours_in_same_col cell
      unset_group_neighbours_of_cell(cell).select{|c| c.col == cell.col}
    end

    def unset_group_neighbours_not_in_same_col cell
      unset_group_neighbours_of_cell(cell).select{|c| c.col != cell.col}
    end

    def all_unset_group_neighbours_in_same_row_share_possible_value? cell, possible_value
      unset_group_neighbours_in_same_row(cell).select{|c| c.possible_values.include? possible_value}.count == unset_group_neighbours_in_same_row(cell).count
    end

    def all_unset_group_neighbours_in_same_col_share_possible_value? cell, possible_value
        unset_group_neighbours_in_same_col(cell).select{|c| c.possible_values.include? possible_value}.count == unset_group_neighbours_in_same_col(cell).count
    end

    def all_unset_group_neighbours_not_in_same_row_dont_have_possible_value? cell, possible_value
      unset_group_neighbours_not_in_same_row(cell).select{|c| c.possible_values.include? possible_value}.count == 0
    end

    def all_unset_group_neighbours_not_in_same_col_dont_have_possible_value? cell, possible_value
      unset_group_neighbours_not_in_same_col(cell).select{|c| c.possible_values.include? possible_value}.count == 0
    end

    def unset_row_neighbours_not_in_group cell
      unset_row_neighbours_of_cell(cell).select{|c| c.group != cell.group}
    end

    def unset_col_neighbours_not_in_group cell
      unset_col_neighbours_of_cell(cell).select{|c| c.group != cell.group}
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

    def string_to_grid string
      string.split("\n").map { |row| row.split.map { |cell| cell } }
    end
  end
end