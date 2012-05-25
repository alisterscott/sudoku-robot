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
    puts solver.board.to_s
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
    puts solver.board.to_s
  end

  it 'should be able to solve a difficult board' do
    board_string = ' _ _ 6 _ 2 _ _ 7 _
                     2 _ _ 6 _ 4 _ 3 _
                     _ _ _ _ 9 3 4 _ 2
                     _ _ 8 _ _ _ _ 4 7
                     _ _ _ _ _ _ _ _ _
                     7 6 _ _ _ _ 1 _ _
                     4 _ 3 8 6 _ _ _ _
                     _ 7 _ 1 _ 9 _ _ 8
                     _ 8 _ _ 3 _ 6 _ _        '
    solver = Sudoku::Solver.new board_string
    puts solver.board.to_s
    solver.should be_solved
  end
end