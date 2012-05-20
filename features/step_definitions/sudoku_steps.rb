Given /^a sudoku board:$/ do |board_string|
	@board = create_board board_string
end

When /^I analyse the board$/ do
	@analysis = Sudoku::BoardAnalyser.new @board
end

Then /^cell (\d+),(\d+) can contain an? (\d+) or an? (\d+)$/ do |row, col, val1, val2|
	@analysis.possible_values_for(row, col).should == [val1, val2]
end