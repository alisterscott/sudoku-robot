class Sudoku::SquareGroup
  include Enumerable
  include Sudoku

  ROW_COUNT = 3
  COL_COUNT = 3

  attr_reader :grid

  def initialize grid
    @grid = grid.kind_of?(Array) ? grid : string_to_grid(grid) 
    @grid.each do |row|
    	raise "invalid square group grid, should be 3 x 3 '#{@grid}'" unless row.length == ROW_COUNT and @grid.length == COL_COUNT
		end		
  end
end