class Sudoku::GroupAnalyser
  include Sudoku

  attr_reader :group

  def initialize group
    @group = group
  end

  def all_possible_values
    [1,2,3,4,5,6,7,8,9]
  end

  def taken_values
    @group.grid.map {|row| row.reject {|cell| cell == "_"}.map{|cell| cell.to_i} }.flatten
  end

  def possible_values_for row, col
    return [] unless @group.grid[row.to_i][col.to_i] == "_"
    all_possible_values - taken_values
  end
end