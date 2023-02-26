Feature: GET Gitlab Issue

    Background: 
    * url 'https://gitlab.com/api/v4'
    * header Authorization = 'Bearer ' + 'glpat-fx8cxyo8Ph8fRSAxFixk'

    @Positive @GetIssues
    Scenario: GET All Gitlab Issues
        Given path '/issues'
        When method GET
        Then status 200
        And print response

    @Positive
    Scenario: GET Gitlab Issues with existing assignee id(Issue assigned to the author itself)
        * def getFeature = call read('ListIssues.feature@GetIssues')
        * def responseGet = getFeature.response
        * def valid_assignee_id = responseGet[0].author.id
        Given path '/issues'
        And param assignee_id = valid_assignee_id
        When method GET
        Then status 200
        And print response
        And assert response.length >= 1
        
    @Positive
    Scenario Outline: GET Gitlab Issues with non-existing(random number) assignee id
        Given path '/issues'
        And param assignee_id = assigneeId
        When method GET
        Then status 200
        And print response
        And assert response.length == 0
        Examples:
            | assigneeId |
            | 1111 |
            | 0000 |
            | 1234 |

    @Negative
    Scenario Outline: GET Gitlab Issues with invalid(string/special characters) assignee id
        Given path '/issues'
        And param assignee_id = assigneeId
        When method GET
        Then status 400
        And print response
        And def expectedError = "assignee_id should be an integer, none, or any, however got " + assigneeId
        And match response.error == expectedError
        Examples:
            | assigneeId |
            | XY*Z |
            | ABCD |
            | ???? |

    @Positive
    Scenario Outline: GET Gitlab Issues with correct datatype(boolean) for Confidential Param
        Given path '/issues'
        And param confidential = confidentialValue
        When method GET
        Then status 200
        And print response
        Examples:
            | confidentialValue |
            | true |
            | false|

    @Negative
    Scenario Outline: GET Gitlab Issues with incorrect datatype for Confidential Param
        Given path '/issues'
        And param confidential = confidentialValue
        When method GET
        Then status 400
        And print response
        And def expectedError = "confidential is invalid"
        And match response.error == expectedError
        Examples:
            | confidentialValue |
            | 12345 |
            | ABCDE |
            | ????? |
