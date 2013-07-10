Feature: Menu
 @javascript
 Scenario: Open page from root page
  Given there is a page with the name "Sale dad-hedgehog" 
  And the page "Sale dad-hedgehog" has child "Sale child-hedgehog"
  When I am on the root page
  And I should see "SALE DAD-HEDGEHOG"  
  And I should not see "SALE CHILD-HEDGEHOG"
  And I select link "Sale dad-hedgehog" from menu
  Then I should see "SALE CHILD-HEDGEHOG"  
