class Sudoku::StraightGroup
  include Enumerable
  include Sudoku

	attr_reader :grid, :row_count, :col_count
	LENGTH = 9
	WIDTH = 1

  def initialize grid
    @grid = grid.kind_of?(Array) ? grid : string_to_grid(grid) 
    @row_count = @grid.length
    raise "invalid straight grid, should be 1 x 9, or 9 x 1 '#{@grid}'" unless @grid.length == LENGTH or @grid.length == WIDTH
    @grid.each do |row|
    	@col_count = row.length
    	unless (@row_count == LENGTH and @col_count == WIDTH) or (@row_count == WIDTH and @col_count == LENGTH)
	    	raise "invalid square group grid, should be 3 x 3 '#{@grid}'"
	    end
	  end		
  end
end