Given /^a sudoku square group:$/ do |board_string|
	@square_group = Sudoku::SquareGroup.new board_string
end

When /^I analyse the square group$/ do
	@analysis = Sudoku::GroupAnalyser.new @square_group
end

Then /^cell (\d+),(\d+) can contain an? (\d+) or an? (\d+)$/ do |row, col, val1, val2|
	@analysis.possible_values_for(row, col).should == [val1, val2]
end