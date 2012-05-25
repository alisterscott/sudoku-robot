Feature: Web Game

Scenario: Can play an easy game
  Given I start a new easy game
  When I solve the game
  Then the game should be solved