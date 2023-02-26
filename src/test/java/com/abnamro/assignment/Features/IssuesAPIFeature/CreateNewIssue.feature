Feature: POST Gitlab Issue

    Background:
    * url baseURL
    * header Authorization = 'Bearer ' + access_token
    * def requestBody = read('/../../Resources/request.json')
    * def invalidRequestBody = read('/../../Resources/invalidRequest.json')
    * def expectedResponse = read('/../../Resources/response.json')
    * def getFeature = call read('ListIssues.feature@GetIssues')
    * def responseGet = getFeature.response
    * def project_id = responseGet[0].project_id
    * def iid = responseGet[0].iid

    @Positive
    Scenario: Create a new Gitlab issue for a valid Project ID
    Given path '/projects/'+project_id+'/issues'
    And request requestBody
    When method POST
    Then status 201
    And match response.project_id == project_id
    And match response.title == requestBody.title
    And match response.labels[0] == requestBody.labels
    And match response == expectedResponse
    And print response

    @Negative
    Scenario Outline: Create a new issue for a invalid project ID
    Given path '/projects/'+invalid_project_id+'/issues'
    And request requestBody
    When method POST
    Then status 404
    And match response.message == "404 Project Not Found"
    And print response
    Examples:
        | invalid_project_id |
        | 1111 |
        | ABCD |
        | ???? |

    @Negative
    Scenario: Create a new issue without a project ID
    Given path '/projects/issues'
    And request requestBody
    When method POST
    Then status 404
    And match response.error == "404 Not Found"
    And print response

    @Negative
    Scenario: Create a new issue without the required parameter
    Given path '/projects/'+project_id+'/issues'
    And request invalidRequestBody
    When method POST
    Then status 400
    And match response.error == "title is missing"
    And print response
    