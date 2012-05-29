$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku/board'
require 'sudoku/board_analyser'
require 'sudoku/cell'

describe Sudoku::BoardAnalyser do
  let :board_analyser do
    board_string = ' 1 _ _ _ _ _ _ _ 2
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ 3 _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     4 _ _ _ _ _ _ _ 5     '
    Sudoku::BoardAnalyser.new board_string
  end

  it 'should be able to determine what values a cell can be by looking at its group' do
    board_analyser.board.groups[4].first.possible_values.to_a.should == ["1", "2", "4", "5", "6", "7", "8", "9"]
  end

  it 'should be able to determine what values a cell can be by looking at its row' do
    board_analyser.board.rows.first[1].possible_values.to_a.should == ["3", "4", "5", "6", "7", "8", "9"]
  end

  it 'should be able to determine what values a cell can be by looking at its col' do
    board_analyser.board.cols.first[1].possible_values.to_a.should == ["2", "3", "5", "6", "7", "8", "9"]
  end

  it 'should be able to see a simple group missing number' do
    board_string = ' 1 2 3 _ _ _ _ _ _
                     4 5 6 _ _ _ _ _ _
                     7 8 _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.board.groups.first.last.possible_values.to_a.should == ["9"]
    board_analyser.known_values.count == 1
    board_analyser.known_values.first.possible_values.to_a.should == ["9"]
  end

  it 'should be able to see a simple row missing number' do
    board_string = ' 1 2 3 4 5 6 7 8 _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.board.rows.first.last.possible_values.to_a.should == ["9"]
    board_analyser.known_values.count == 1
    board_analyser.known_values.first.possible_values.to_a.should == ["9"]
  end

  it 'should be able to see a simple column missing number' do
    board_string = ' _ _ _ _ _ _ _ _ _
                     2 _ _ _ _ _ _ _ _
                     3 _ _ _ _ _ _ _ _
                     4 _ _ _ _ _ _ _ _
                     5 _ _ _ _ _ _ _ _
                     6 _ _ _ _ _ _ _ _
                     7 _ _ _ _ _ _ _ _
                     8 _ _ _ _ _ _ _ _
                     9 _ _ _ _ _ _ _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.board.cols.first.first.possible_values.to_a.should == ["1"]
    board_analyser.known_values.count == 1
    board_analyser.known_values.first.possible_values.to_a.should == ["1"]
  end

  it 'should be able find known values from a unique known value' do
    board_string = ' _ _ _ 2 6 8 _ _ _
                     _ _ _ _ _ _ 5 _ 8
                     8 2 _ 1 _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.known_values.count.should == 1
    board_analyser.board.rows[1][7].possible_values.to_a.should == ["2"]
  end

  it 'should know about advanced cross-hatching' do
    board_string = ' _ _ _ _ _ _ 2 _ _
                     _ _ _ 9 _ _ _ _ _
                     _ _ _ 3 6 _ _ 4 5
                     _ _ _ _ _ _ _ _ _
                     _ _ 2 _ _ _ 9 _ _
                     _ _ 9 _ _ _ _ _ _
                     8 9 _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.known_values
    board_analyser.board.rows[2][0].possible_values.to_a.should == ["9"]
  end

  it 'should know about advanced cross-hatching when rotated' do
    board_string = ' _ _ 8 _ _ _ _ _ _
                     _ _ 9 _ _ _ _ _ _
                     _ _ _ 9 _ _ _ _ _
                     _ _ _ _ _ _ 3 9 _
                     _ _ _ _ _ _ 6 _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ 9 _ _ _ 2
                     _ _ _ _ _ _ 4 _ _
                     _ _ _ _ _ _ 5 _ _     '
    board_analyser = Sudoku::BoardAnalyser.new board_string
    board_analyser.known_values
    board_analyser.board.rows[0][6].possible_values.to_a.should == ["9"]
  end
end