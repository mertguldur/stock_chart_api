Feature: Companies

  Scenario: Same case prefix search
    Given I have companies with names "AA, AB, BB"
    When I send a GET request to "companies?prefix=A"
    Then the response status should be "200"
    And the JSON response data should be:
      """
      [
        {
          "id": "#{@companies['AA'].id}",
          "type": "companies",
          "attributes": {
            "symbol": "#{@companies['AA'].symbol}",
            "name": "AA"
          }
        },
        {
          "id": "#{@companies['AB'].id}",
          "type": "companies",
          "attributes": {
            "symbol": "#{@companies['AB'].symbol}",
            "name": "AB"
          }
        }
      ]
      """

  Scenario: Different case prefix search
    Given I have companies with names "AA, AB, BB"
    When I send a GET request to "companies?prefix=a"
    Then the response status should be "200"
    And the JSON response data should be:
      """
      [
        {
          "id": "#{@companies['AA'].id}",
          "type": "companies",
          "attributes": {
            "symbol": "#{@companies['AA'].symbol}",
            "name": "AA"
          }
        },
        {
          "id": "#{@companies['AB'].id}",
          "type": "companies",
          "attributes": {
            "symbol": "#{@companies['AB'].symbol}",
            "name": "AB"
          }
        }
      ]
      """

  Scenario: No companies
    When I send a GET request to "companies"
    Then the response status should be "200"
    And the JSON response data should be:
      """
      []
      """

   Scenario: Page size
    Given I have "26" companies
    When I send a GET request to "companies"
    Then the response status should be "200"
    And I should only see "25" items in JSON response data

  Scenario: Page 2
    Given I have "26" companies
    When I send a GET request to "companies?page=2"
    Then the response status should be "200"
    And I should only see "1" items in JSON response data

  Scenario: Pagination data
    Given I have "26" companies
    When I send a GET request to "companies"
    Then the response status should be "200"
    And the JSON response pagination data should be:
      """
      {
        "per-page": 25,
        "total-pages": 2,
        "total-count": 26
      }
      """
