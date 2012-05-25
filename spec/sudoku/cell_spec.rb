$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku'
require 'sudoku/cell'

describe Sudoku::Cell do
  it 'should know the square group to which it belongs - first cell' do
    cell = Sudoku::Cell.new 0,0,"_"
    cell.group.should == 0
  end

  it 'should know the square group to which it belongs - right cell' do
    cell = Sudoku::Cell.new 2,6,"_"
    cell.group.should == 2
  end

  it 'should know the square group to which it belongs - middle cell' do
    cell = Sudoku::Cell.new 4,4,"_"
    cell.group.should == 4
  end

  it 'should know the square group to which it belongs - left cell' do
    cell = Sudoku::Cell.new 6,3,"_"
    cell.group.should == 7
  end

  it 'should know the square group to which it belongs - last cell' do
    cell = Sudoku::Cell.new 8,8,"_"
    cell.group.should == 8
  end

  it 'should know its index in the grid' do
    cell = Sudoku::Cell.new 0,0,"_"
    cell.grid_index.should == 0
  end

  it 'should know its index in the grid' do
    cell = Sudoku::Cell.new 8,8,"_"
    cell.grid_index.should == 80
  end

end