@evil-ways @evil-undo
Feature: Evil Undo
  Background:
    Given I turn on evil-mode

  @pr-bugs @visual-undo @failing
  Scenario: Remove a character from visual state and undo
    When I replace the buffer text with:
    """
    test
    test
    """
    And I press "C->"
    And I press "vlx"
    And I press "ux"
    Then I should see exactly:
    """
    tst
    tst
    """
