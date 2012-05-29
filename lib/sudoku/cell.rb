require 'set'

module Sudoku
  class Cell
    BOARD_SIZE = 3
    ROW_LENGTH = 9
    ALL_POSSIBLE_VALUES = Set.new ["1","2","3","4","5","6","7","8","9"]

    attr_reader :row, :col, :group
    attr_accessor :possible_values, :value

    def initialize row, col, value
      @row = row
      @col = col
      @value = value
      @group = ((col/BOARD_SIZE).to_i) + (BOARD_SIZE * (row/BOARD_SIZE).to_i)
      @possible_values = value == "_" ? ALL_POSSIBLE_VALUES : Set.new
    end

    # the position in the grid
    def grid_index
      @row * ROW_LENGTH + @col
    end
  end
end