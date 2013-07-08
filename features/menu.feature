Feature: Menu
 
 Scenario: Open page from root page
  Given there is a page with the name "Sale dad-hedgehog" 
  And the page "Sale dad-hedgehog" has child "Sale child-hedgehog"
  When I am on the root page
  And I should see "Sale dad-hedgehog"  
  And I should not see "Sale child-hedgehog"
  And I follow "Sale dad-hedgehog"
  Then I should see "Sale child-hedgehog"  
