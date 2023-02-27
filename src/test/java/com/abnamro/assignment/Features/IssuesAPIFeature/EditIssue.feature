Feature: Update Gitlab Issue

    Background:
    * url baseURL
    * def access_token = karate.properties['token']
    * header Authorization = 'Bearer ' + access_token
    * def requestBody = read('/../../Resources/request.json')
    * def updateRequestCombination = read('/../../Resources/updateRequestComination.json')
    * def updateNullRequest = read('/../../Resources/updateNullRequest.json')
    * def invalidUpdateRequest = read('/../../Resources/invalidUpdateRequest.json')
    * def updateToClose = read('/../../Resources/updateToClose.json')
    * def updateRequest = read('/../../Resources/updateRequest.json')
    * def getFeature = call read('ListIssues.feature@GetIssues')
    * def responseGet = getFeature.response
    * def project_id = responseGet[0].project_id
    * def iid = responseGet[0].iid

    @Positive
    Scenario: Update the Gitlab issue with the required parameters(Update the title and description of the existing issue)
    Given path '/projects/'+project_id+'/issues/'+iid
    And request updateRequest
    When method PUT
    Then status 200
    And match response.project_id == project_id
    And match response.iid == iid
    And match response.title == updateRequest.title
    And match response.description == updateRequest.description
    And print response


    @Positive
    Scenario: Updatethe Status of the issue to Closed
    Given path '/projects/'+project_id+'/issues/'+iid
    And request updateToClose
    When method PUT
    Then status 200
    And match response.project_id == project_id
    And match response.iid == iid
    And match response.state == "closed"
    And print response
    
    
    @Negative
    Scenario: Update the Gitlab issue without the required parameters
    Given path '/projects/'+project_id+'/issues/'+iid
    And request invalidUpdateRequest
    When method PUT
    Then status 400
    And match response.error == "assignee_id, assignee_ids, confidential, created_at, description, discussion_locked, due_date, labels, add_labels, remove_labels, milestone_id, state_event, title, issue_type, weight, epic_id, epic_iid are missing, at least one parameter must be provided"

    @Negative
    Scenario: Update the Gitlab issue with null values of the required parameters
    Given path '/projects/'+project_id+'/issues/'+iid
    And request updateNullRequest
    When method PUT
    Then status 400
    And match response.message.title[0] == "can't be blank"


    @Negative
    Scenario: Update the Gitlab issue with combination of valid and invalid values of the required parameters
    Given path '/projects/'+project_id+'/issues/'+iid
    And request updateRequestCombination
    When method PUT
    Then status 400
    And match response.error == "confidential is invalid"

    
    @Negative
    Scenario Outline: Update the Gitlab issue with the required parameters for invalid Project ID and invalid IID
    Given path '/projects/'+invalid_project_id+'/issues/'+invalid_iid
    And request requestBody
    When method PUT
    Then status 404
    And print response
    And match response.message == "404 Project Not Found"
    Examples:
        | invalid_project_id | invalid_iid |
        | 1111 | 1111|
        | ABCD | 2222|
        | ???? | 0000|

    @Negative
    Scenario: Update the Gitlab issue with the required parameters and invalid oauth2 token
    Given path '/projects/'+project_id+'/issues/'+iid
    And header Authorization = 'Bearer ' + invalid_access_token
    And request updateRequest
    When method PUT
    Then status 401
    And match response.message == "401 Unauthorized"
    And print response