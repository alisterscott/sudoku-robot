$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku'
require 'sudoku/board'

describe Sudoku::Board do
  let :board do
    board_string = ' 1 _ _ _ _ _ _ _ 2
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ 3 _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     4 _ _ _ _ _ _ _ 5     '
    Sudoku::Board.new board_string
  end

  it 'should be able to be initialized from a string' do
    board.count.should == 81
  end

  it 'should provide an unknown cell count' do
   board.unknown_cell_count.should == 76
  end

  it 'should know whether it is solved' do
    board.should_not be_solved
  end

  it 'should be create a whole bunch of cells' do
    board.cells.first.row.should == 0
    board.cells[8].col.should == 8
    board.cells[40].group.should == 4
    board.cells[80].value.should == "5"
  end

  it 'should create groups of cells based upon group id (0-8)' do
    board.groups.count.should == 9
    board.groups.first.count.should == 9
    board.groups.first.first.value.should == "1"
  end

  it 'should create rows of cells based upon row id (0-8)' do
    board.rows.count.should == 9
    board.rows.first.count.should == 9
    board.rows.first.last.value.should == "2"
  end

  it 'should create cols of cells based upon col id (0-8)' do
    board.cols.count.should == 9
    board.cols.first.count.should == 9
    board.cols.last.first.value.should == "2"
    board.cols.last.last.value.should == "5"
  end

  it 'should be able to determine what values a cell can be by looking at its group' do
    board.groups[4].first.possible_values.to_a.should == ["1","2","4","5","6","7","8","9"]
  end

  it 'should be able to determine what values a cell can be by looking at its row' do
    board.rows.first[1].possible_values.to_a.should == ["3","4","5","6","7","8","9"]
  end

  it 'should be able to determine what values a cell can be by looking at its col' do
    board.cols.first[1].possible_values.to_a.should == ["2","3","5","6","7","8","9"]
  end
end

describe 'Solving Sudoku::Board' do
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
    board = Sudoku::Board.new board_string
    board.groups.first.last.possible_values.to_a.should == ["9"]
    board.known_values.count == 1
    board.known_values.first.possible_values.to_a.should == ["9"]
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
    board = Sudoku::Board.new board_string
    board.rows.first.last.possible_values.to_a.should == ["9"]
    board.known_values.count == 1
    board.known_values.first.possible_values.to_a.should == ["9"]
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
    board = Sudoku::Board.new board_string
    board.cols.first.first.possible_values.to_a.should == ["1"]
    board.known_values.count == 1
    board.known_values.first.possible_values.to_a.should == ["1"]
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
    board = Sudoku::Board.new board_string
    board.rows[1][7].possible_values.to_a.should == ["1", "2", "3", "4", "6", "7", "9"]
    board.known_values.count.should == 1
    board.rows[1][7].possible_values.to_a.should == ["2"]
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
    board = Sudoku::Board.new board_string
    board.known_values
    board.rows[2][0].possible_values.to_a.should == ["9"]
  end
end