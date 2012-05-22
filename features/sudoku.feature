Feature: Sudoku

Scenario: Can work out possible values for a cell in a square group
	Given a sudoku square group:
	"""
	1 2 3
	4 5 6
	7 _ _
	"""
	When I analyse the square group
	Then cell 2,1 can contain an 8 or a 9
	And cell 2,2 can contain an 8 or a 9

Scenario: Can work out possible values for a cell in a horizontal straight group
  Given a sudoku straight group
  """
  _ _ 3 4 5 6 7 8 9
  """
  When I analyse the straight group
  Then cell 0,0 can contain a 1 or a 2
  And cell 0,1 can contain a 1 or a 2

Scenario: Can work out possible values for a cell in a vertical straight group
  Given a sudoku straight group
  """
  9
  8
  7
  _
  _
  1
  2
  3
  4
  """
  When I analyse the straight group
  Then cell 3,0 can contain a 5 or a 6
  And cell 4,0 can contain a 5 or a 6