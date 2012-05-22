Given /^a sudoku square group:$/ do |string|
	@square_group = Sudoku::SquareGroup.new string
end

Given /^a sudoku straight group$/ do |string|
  @straight_group = Sudoku::StraightGroup.new string
end

When /^I analyse the straight group$/ do
	@analysis = Sudoku::GroupAnalyser.new @straight_group
end

When /^I analyse the square group$/ do
	@analysis = Sudoku::GroupAnalyser.new @square_group
end

Then /^cell (\d+),(\d+) can contain an? (\d+) or an? (\d+)$/ do |row, col, val1, val2|
	@analysis.possible_values_for(row, col).should == [val1.to_i, val2.to_i]
end