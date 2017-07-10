@evil-ways @evil-undo
Feature: Evil Undo
  Background:
    Given I turn on evil-mode

  @failing
  Scenario: Paste and undo
    When I replace the buffer text with:
    """
    test
    test
    """
    And I press "yl"
    And I press "C-$"
    And I press "<escape>"
    And I press "p"
    Then I should see exactly:
    """
    ttest
    ttest
    """
    # should be 4 u's, but for the tests it is 3
    And I press "uuu"
    Then I should see exactly:
    """
    test
    test
    """
    And I press "x"
    Then I should see exactly:
    """
    est
    est
    """
