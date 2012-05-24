require 'set'

class Sudoku::Cell
  BOARD_SIZE = 3
  ALL_POSSIBLE_VALUES = Set.new ["1","2","3","4","5","6","7","8","9"]

  attr_reader :row, :col, :value, :group
  attr_accessor :possible_values

  def initialize row, col, value
    @row = row
    @col = col
    @value = value
    @group = ((col/BOARD_SIZE).to_i) + (BOARD_SIZE * (row/BOARD_SIZE).to_i)
    @possible_values = value == "_" ? ALL_POSSIBLE_VALUES : Set.new
  end
end