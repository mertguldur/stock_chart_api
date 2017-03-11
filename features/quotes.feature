Feature: Quotes

  Scenario: No company ID is given
    When I send a GET request to "api/quotes"
    Then the response status should be "404"

  Scenario: Company doesn't exist
    When I send a GET request to "api/quotes?company_id=1"
    Then the response status should be "404"

  Scenario: Retrieve quotes
    Given I have a company
    And Yahoo Finance API is able to return quotes with the following attributes
      | trade_date | low  | high | open | close |
      | 2017-03-09 | 3.41 | 3.47 | 3.47 | 3.45 |
      | 2017-03-08 | 3.30 | 3.50 | 3.50 | 3.40 |
    When I send a GET request to "api/quotes?company_id=#{@company.id}"
    Then the response status should be "200"
    And the JSON response data should be:
      """
      [
        {
          "id": "1",
          "type": "quotes",
          "attributes": {
            "date": "2017-03-08",
            "average": "3.43"
          }
        },
        {
          "id": "2",
          "type": "quotes",
          "attributes": {
            "date": "2017-03-09",
            "average": "3.45"
          }
        }
      ]
      """
