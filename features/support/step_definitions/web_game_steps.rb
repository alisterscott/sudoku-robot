Given /^I start a new (.+) game$/ do |level|
  @game = Sudoku::WebGame.new @browser, level
end

When /^I solve the game$/ do
  @solver = Sudoku::Solver.new @game.grid_string
end

Then /^the game should be solved$/ do
  @solver.should be_solved
  @game.set_cells @solver.moves
  @game.click_how_am_i_doing
  @game.browser.text.should include 'Congratulations! You solved this Sudoku!'
end