$: << File.dirname(__FILE__)+'/../../lib'

require 'sudoku/board'
require 'sudoku/cell'

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

  it 'should provide a cell_at method' do
    board.cell_at(0,0).value.should == "1"
    board.cell_at(8,8).value.should == "5"
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

  it 'should be enumerable' do
    board.each{|cell| cell.class == Sudoku::Cell }
  end

  it 'provides a to string method' do
    board.to_s.should == "\n1 _ _ _ _ _ _ _ 2 \n_ _ _ _ _ _ _ _ _ \n_ _ _ _ _ _ _ _ _ \n_ _ _ _ _ _ _ _ _ \n_ _ _ _ 3 _ _ _ _ \n_ _ _ _ _ _ _ _ _ \n_ _ _ _ _ _ _ _ _ \n_ _ _ _ _ _ _ _ _ \n4 _ _ _ _ _ _ _ 5 "
  end

  it 'provides group neighbours of cells' do
    board.group_neighbours_of_cell(board.cell_at(1,1)).count.should == 8
    board.group_neighbours_of_cell(board.cell_at(1,1)).first.value.should == "1"
    board.group_neighbours_of_cell(board.cell_at(1,1)).last.value.should == "_"
  end

  it 'provides row neighbours of cells' do
    board.row_neighbours_of_cell(board.cell_at(0,4)).count.should == 8
    board.row_neighbours_of_cell(board.cell_at(0,4)).first.value.should == "1"
    board.row_neighbours_of_cell(board.cell_at(0,4)).last.value.should == "2"
  end

  it 'provides col neighbours of cells' do
    board.col_neighbours_of_cell(board.cell_at(4,0)).count.should == 8
    board.col_neighbours_of_cell(board.cell_at(4,0)).first.value.should == "1"
    board.col_neighbours_of_cell(board.cell_at(4,0)).last.value.should == "4"
  end

  it 'provides unset row neighbours of cell' do
    board.unset_row_neighbours_of_cell(board.cell_at(0,4)).count.should == 6
    board.unset_row_neighbours_of_cell(board.cell_at(0,4)).each{|cell|cell.value.should == "_"}
  end

  it 'provides unset col neighbours of cell' do
    board.unset_col_neighbours_of_cell(board.cell_at(4,0)).count.should == 6
    board.unset_col_neighbours_of_cell(board.cell_at(4,0)).each{|cell|cell.value.should == "_"}
  end

  it 'provides unset group neighbours of cell' do
    board.unset_group_neighbours_of_cell(board.cell_at(1,1)).count.should == 7
    board.unset_group_neighbours_of_cell(board.cell_at(1,1)).each{|cell|cell.value.should == "_"}
  end

  it 'provides unset group neighbours of cell in same row' do
    board.unset_group_neighbours_in_same_row(board.cell_at(0,1)).count.should == 1
    board.unset_group_neighbours_in_same_row(board.cell_at(0,1)).first.value.should == "_"
    board.unset_group_neighbours_in_same_row(board.cell_at(0,1)).first.row.should == 0
  end

  it 'provides unset group neighbours of cell not in same row' do
    board.unset_group_neighbours_not_in_same_row(board.cell_at(0,1)).count.should == 6
    board.unset_group_neighbours_not_in_same_row(board.cell_at(0,1)).each{|cell|cell.value.should == "_"}
    board.unset_group_neighbours_not_in_same_row(board.cell_at(0,1)).each{|cell|cell.row.should_not == 0}
  end

  it 'provides unset group neighbours of cell in same col' do
    board.unset_group_neighbours_in_same_col(board.cell_at(1,0)).count.should == 1
    board.unset_group_neighbours_in_same_col(board.cell_at(1,0)).first.value.should == "_"
    board.unset_group_neighbours_in_same_col(board.cell_at(1,0)).first.col.should == 0
  end

  it 'provides unset group neighbours of cell not in same col' do
    board.unset_group_neighbours_not_in_same_col(board.cell_at(1,0)).count.should == 6
    board.unset_group_neighbours_not_in_same_col(board.cell_at(1,0)).each{|cell|cell.value.should == "_"}
    board.unset_group_neighbours_not_in_same_col(board.cell_at(1,0)).each{|cell|cell.col.should_not == 0}
  end
end