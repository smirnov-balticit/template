Feature: Pages

  Scenario: Visit each of base page
    When I am on the root page
    Then I should can visit each of base pages

@javascript
  Scenario Outline: Send feedback mail from contacts page
    Given there is a admin user with the email "admin@example.com"
    When I am on the page with slug "contacts"
    Then I fill in "feedback_email" with "<email>"
    And I fill in "feedback_message" with "<message>"
    When I press "Send"
    Then I should see "<result>"
    Then "admin@example.com" should receive <got> email with subject "You have new feedback message"
  Examples:
    | email               | message                         | result                    | got |
    | email@example.com   | I want to work with you!        | Your message in sending!  | an  |
    | AMAZING+E.M.L@ml.ru | I don't want to work with you!  | Your message in sending!  | an  |
    | bad'mail'bad@ml.com | I don't want to work!           | Your e-mail in wrong      | no  |
    | without.dog.mail.ru | Я танцую джигу-дрыгу на столе.. | Your e-mail in wrong      | no  |
    | o@b@m@us.us         | Я Обама. А чего добился ты?     | Your e-mail in wrong      | no  |
    | email@example.com   | I'm a man                       | Your message too short    | no  |
