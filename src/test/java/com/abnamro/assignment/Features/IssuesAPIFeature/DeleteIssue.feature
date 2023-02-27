Feature: Delete Gitlab Issue

    Background:
    * url baseURL
    * def access_token = karate.properties['token']
    * header Authorization = 'Bearer ' + access_token
    * def getFeature = call read('ListIssues.feature@GetIssues')
    * def responseGet = getFeature.response
    * def project_id = responseGet[0].project_id
    * def iid = responseGet[0].iid

@Positive
Scenario: Delete Gitlab issue for a valid Project ID and IID
    Given path '/projects/'+project_id+'/issues/'+iid
    When method DELETE
    Then status 204
    
@Negative
Scenario Outline: Delete Gitlab issue for a valid Project ID and invalid IID(Number Type)
    Given path '/projects/'+project_id+'/issues/'+invalid_iid
    When method DELETE
    Then status 404
    And match response.message == "404 Issue Not Found"
    Examples:
        | invalid_iid |
        | 1111 |
        | 6789 |
        | 0000 |

@Negative
Scenario Outline: Delete Gitlab issue for a valid Project ID and invalid IID(Other than Number Type)
    Given path '/projects/'+project_id+'/issues/'+invalid_iid
    When method DELETE
    Then status 400
    And match response.error == "issue_iid is invalid"
    Examples:
        | invalid_iid |
        | XY*Z |
        | ABCD |
        | ???? |

@Negative
Scenario Outline: Delete Gitlab issue for an invalid Project ID and valid IID
    Given path '/projects/'+invalid_project_id+'/issues/'+iid
    When method DELETE
    Then status 404
    And match response.message == "404 Project Not Found"
    Examples:
        | invalid_project_id |
        | 1111 |
        | ABCD |
        | ???? |

@Negative
Scenario Outline: Delete Gitlab issue for an invalid Project ID and invalid IID
    Given path '/projects/'+invalid_project_id+'/issues/'+invalid_iid
    When method DELETE
    Then status 404
    And match response.message == "404 Project Not Found"
    Examples:
        | invalid_project_id | invalid_iid |
        | 1111 | 1111|
        | ABCD | 2222|
        | ???? | 0000|

@Negative
Scenario: Delete Gitlab issue for a valid Project ID and IID with invalid oauth2 token
    Given path '/projects/'+project_id+'/issues/'+iid
    And header Authorization = 'Bearer ' + invalid_access_token
    When method DELETE
    Then status 401
    And match response.message == "401 Unauthorized"
