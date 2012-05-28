Feature: Web Game

Scenario Outline: Can play a variety of games
  Given I start a new <difficulty> game
  When I solve the game
  Then the game should be solved
 Examples:
  | difficulty |
  | easy       |
  | medium     |
  | hard       |
  | evil       |