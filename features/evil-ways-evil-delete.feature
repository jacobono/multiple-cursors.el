@evil-ways @evil-delete
Feature: Deleted text should be reflected in the buffer
  Background:
    Given I turn on evil-mode
    And I bind evil keys for multiple-cursors mode 

  Scenario: Delete a word
    When I replace the buffer text with "words words and more words"
    And I press "grm"
    And I press "C-g"
    And I type "dw"
    Then I should see "and more "

  Scenario: Delete a letter
    When I replace the buffer text with "words words and more words"
    And I press "grm"
    And I press "C-g"
    And I type "x"
    Then I should see "ords ords and more ords"

  Scenario: Delete a letter with count
    When I replace the buffer text with "words words and more words"
    And I press "grm"
    And I press "C-g"
    And I type "2x"
    Then I should see "rds rds and more rds"
    
  Scenario: Delete a word with count
    When I replace the buffer text with:
    """
    Lots of words words and more words
    Lots of words words and more words
    Lots of words words and more words
    Lots of words words and more words
    """    
    And I press "grm"
    And I press "C-g"
    And I type "fw3dw"
    Then I should see exactly:
    """
    Lots of more words
    Lots of more words
    Lots of more words
    Lots of more words
    """    

  Scenario: Delete a WORD
    When I replace the buffer text with:
    """
    composite-words composite-words and more composite-words
    """    
    And I press "grm"
    And I press "C-g"
    And I type "daW"
    Then I should see "and more"

  # TODO dd doesn't work, but D and d$ do
  @delete-line @todo-delete-evil-line-motion
  Scenario: Delete a line
    When I replace the buffer text with:
    """
    This is a line.
    That is a line.
    That is a line.
    This is a line.
    That is a line.
    """
    And I press "j"
    And I press "grm"
    And I press "C-g"
    And I press "d$"
    Then I should see exactly:
    And I press "d$"
    Then I should see:
    """
    This is a line.
    

    This is a line.

    """
    
  # TODO dd doesn't work, but d$ does
  @delete-line-with-count @todo-delete-evil-line-motion
  Scenario: Delete a line with count
    When I replace the buffer text with:
    """
    That is a line.
    This is a line.
    Another a line.
    That is a line.
    This is a line.
    This is a line.
    That is a line.
    Another a line.
    This is a line.
    Last line.
    """
    And I press "grm"
    And I press "C-g"
    And I press "2d$"
    Then I should see exactly:
    """
    
    Another a line.

    This is a line.

    This is a line.
    Last line.
    """
    
  Scenario: Delete to the end of line
    When I replace the buffer text with:
    """
    This is a super duper long line.
    This is a super duper long line.
    This is a super duper long line.
    This is a super duper long line.
    """
    And I press "grm"
    And I press "C-g"
    And I press "fdD"
    Then I should see exactly:
    """
    This is a super 
    This is a super 
    This is a super 
    This is a super 
    """
    
  Scenario: Delete to the beginning of line
    When I replace the buffer text with:
    """
    This is a super duper long line.
    This is a super duper long line.
    This is a super duper long line.
    This is a super duper long line.
    """
    And I press "grm"
    And I press "C-g"
    And I type "fdd^"
    Then I should see exactly:
    """
    duper long line.
    duper long line.
    duper long line.
    duper long line.
    """
  
  @delete-up-to-a-letter @failing-infinite-loop  
  Scenario: Delete up to a letter
    When I replace the buffer text with:
    """
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    """
    And I press "grm"
    And I press "C-g"
    And I press "fwdfh"
    Then I should see exactly:
    """
    The road  patches of green.
    The road  patches of green.
    The road  patches of green.
    The road  patches of green.
    """
    
  @delete-till-a-letter @failing-infinite-loop  
  Scenario: Delete till before a letter
    When I replace the buffer text with:
    """
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    """
    And I press "grm"
    And I press "C-g"
    And I press "fwdth"
    Then I should see exactly:
    """
    The road h patches of green.
    The road h patches of green.
    The road h patches of green.
    The road h patches of green.
    """
    
  @delete-till-a-letter-with-count @failing-infinite-loop  
  Scenario: Delete till before a letter with count
    When I replace the buffer text with:
    """
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    The road was dark brown with patches of green.
    """
    And I press "grm"
    And I press "C-g"
    And I press "fw2dth"
    Then I should see exactly:
    """
    The road hes of green.
    The road hes of green.
    The road hes of green.
    The road hes of green.
    """
