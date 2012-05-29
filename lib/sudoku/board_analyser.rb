module Sudoku
  class BoardAnalyser
    attr_reader :board

    def initialize grid
      @board = Sudoku::Board.new grid
      set_possible_values
    end

    def set_possible_values
      set_possible_values_from @board.groups
      set_possible_values_from @board.rows
      set_possible_values_from @board.cols
      set_possible_values_where_value_is_unique_in_group
      set_possible_values_from_intersecting_rows_and_cols_in_groups
    end

    def set_possible_values_where_value_is_unique_in_group
      @board.groups.each do |group|
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

    def set_possible_values_from_intersecting_rows_and_cols_in_groups
      @board.groups.each do |group|
        group.each do |cell|
          next unless cell.value == "_"
          cell.possible_values.each do |possible_value|
            if @board.all_unset_group_neighbours_in_same_row_share_possible_value?(cell, possible_value) and @board.all_unset_group_neighbours_not_in_same_row_dont_have_possible_value?(cell, possible_value)
              @board.unset_row_neighbours_not_in_group(cell).each do |cell|
                cell.possible_values.delete possible_value
              end
            end
            if @board.all_unset_group_neighbours_in_same_col_share_possible_value?(cell, possible_value) and @board.all_unset_group_neighbours_not_in_same_col_dont_have_possible_value?(cell, possible_value)
              @board.unset_col_neighbours_not_in_group(cell).each do |cell|
                cell.possible_values.delete possible_value
              end
            end
          end
        end
      end
    end

    def known_values
      set_possible_values
      @board.cells.select {|cell| cell.possible_values.count == 1}
    end

    def set_known_values
      kvs = known_values
      kvs.each do |cell|
        cell.value = cell.possible_values.first
        cell.possible_values = []
      end
      set_possible_values
      kvs
    end

    private

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
end