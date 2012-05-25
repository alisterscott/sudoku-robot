$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku'
require 'sudoku/web_game'
require 'sudoku/solver'
require 'sudoku/board'
require 'sudoku/cell'

require 'watir-webdriver'

browser = Watir::Browser.new

Before do
  @browser = browser
end

at_exit do
  browser.close
end