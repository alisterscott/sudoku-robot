$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku'
require 'sudoku/solver'

describe Sudoku::Solver do
  it 'should be able to solve a simple board' do
    board_string = ' _ 1 _ _ _ _ 2 8 _
                     _ _ 8 _ _ 2 _ 3 _
                     5 2 _ _ 8 _ 7 _ 6
                     7 4 _ 9 _ 5 _ 6 1
                     _ _ _ 1 _ 4 _ _ _
                     9 5 _ 2 _ 8 _ 7 3
                     4 _ 7 _ 1 _ _ 5 2
                     _ 9 _ 6 _ _ 3 _ _
                     _ 8 6 _ _ _ _ 4 _     '
    solver = Sudoku::Solver.new board_string
    solver.should be_solved
  end

  it 'should not be able to solve an unsolvable board' do
    board_string = ' 1 _ _ _ _ _ _ _ 2
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ 3 _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     _ _ _ _ _ _ _ _ _
                     4 _ _ _ _ _ _ _ 5        '
    solver = Sudoku::Solver.new board_string
    solver.should_not be_solved
    solver.moves.count.should == 0
  end


  it 'should be able to solve a medium board' do
    board_string = '_ _ _ _ _ _ 7 4 5
                    _ 2 9 _ _ 5 3 _ _
                    _ 7 _ _ _ 8 _ _ _
                    _ _ _ 9 8 _ 4 5 7
                    _ 8 _ _ 5 _ _ 3 _
                    4 5 2 _ 3 7 _ _ _
                    _ _ _ 1 _ _ _ 9 _
                    _ _ 3 5 _ _ 2 7 _
                    7 4 5 _ _ _ _ _ _ '
    solver = Sudoku::Solver.new board_string
    solver.should be_solved
  end

  it 'should be able to solve a hard board' do
    board_string = '1 _ _ 8 9 _ _ _ 5
                    _ _ 3 _ _ _ _ _ _
                    5 8 _ _ _ 6 2 _ _
                    _ _ 9 _ _ 4 _ _ _
                    _ 2 5 _ _ _ 4 3 _
                    _ _ _ 9 _ _ 7 _ _
                    _ _ 2 7 _ _ _ 5 6
                    _ _ _ _ _ _ 8 _ _
                    3 _ _ _ 1 5 _ _ 4 '
    solver = Sudoku::Solver.new board_string
    solver.should be_solved
  end

end