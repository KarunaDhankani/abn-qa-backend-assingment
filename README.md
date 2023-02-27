# Backend Test Automation Assignment [![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/from-referrer/)

<a href="https://gitpod.io/from-referrer/" style="padding: 10px;">
    <img src="https://gitpod.io/button/open-in-gitpod.svg" width="150" alt="Push">
</a>

## Requirements
### Environment
* GitHub account
* Java 11 (JDK) (optionally)
* Maven 3.6+ (optionally)
* Any IDE you comfortable with (eg. IntelliJ, VSCode)

### Skills
* Java 8+ (coding standards)
* Clean Code
* Maven
* Git, GitLab, GitHub

### Instructions
Fork this project
<details>
<summary>Example</summary>

   ![img.png](doc/img/01_fork_project.png)
</details>

#### Working in Web IDE (preferable)

1. Open Project in [GitPod](https://gitpod.io/from-referrer/):
2. Sing-in with GitHub account
3. Create and commit your solution into your forked repository
4. Create documentation in the README.md under the `Documentation` section
5. IMPORTANT: Enable Repository permissions (e.g. git push) for GitPod when coding from Web IDE here:
   https://gitpod.io/integrations
   <details>
   <summary>Details here</summary>

   Edit permission for GitHub:

   ![img.png](doc/img/02_integration_providers.png)

   ![img.png](doc/img/02_enable_repo_permissions.png)
   </details>

## Documentation
### QA Backend Automation Assignment

This is a project built to cover the CRUD operations on Gitlab Issues API. I have used Karate framework to automate the API testcases. To perform any operations on Gitlab API, you would require oauth2 token, which can also be generated in this project. Detailed explanation of functionality is explained in the following sections of this documentation.

#### Requirement

 To automate the tests that cover following operations on GITLAB API.

| Operation | Description |
| --- | --- |
| List Issues | This operation is to Get all issues the authenticated user has access to. https://gitlab.com/api/v4/issues - This API returns all the issues the current user has access to.One can also GET Gitlab Issues for specific assignee id by passing the assignee id as the parameter to the URL, for ex :     https://gitlab.com/api/v4/issues?assignee_id. Added to that I have also demonstrated the scenario of retrieving all the confidential and non-confidential issues by providing the boolean value to parameter - Confidential.For ex: https://gitlab.com/api/v4/issues?confidential |
| Create New Issue | This operation creates a new project issue using API - https://gitlab.com/api/v4/projects/project_id/issues. User has to provide "title" and "description" as part of request body to create a new issue. As part of validating the response of this API call, I am matching the response received of this POST call to the request body title,description and json schema of the response. |
| Edit Issue | This operation is used to update an existing project issue by providing project id and issue id to the API: https://gitlab.com/api/v4/projects/project_id/issues/iid .For the successful execution of this request,atleast one of the required parameter must be provided as part of the request body. This call is also used to mark an issue as closed by providing state_event=close. |
| Delete Issue | This operation is to delete a project issue by providing the project id and issue id to the API : https://gitlab.com/api/v4/projects/project_id/issues/iid.|
 
In this solution, I have fetched the assignee_id, project_id and iid from the response of GET all issues API.I have filtered the author id from its response and using this author_id as assignee_id to get all the issues assigned to the author itself. Along with the positive scenarios I have also automated some negative scenarios which can also be found in their respective feature files.
 
#### Sample Feature File

In this project there are 4 feature files which are kept under folder `/abn-qa-backend-assingment/src/test/java/com/abnamro/assignment/Features/IssuesAPIFeature`

| Feature File | Description |
| --- | --- |
| CreateNewIssue | This feature file is created to create new issue using Gitlab Issue API(POST) |
| ListIssues | This feature file is created to retrieve all the issues using Gitlab Issue API(GET) |
| EditIssue | This feature file is created to update the existing issue using Gitlab Issue API(PUT) |
| DeleteIssue | This feature file is created to delete an issue using Gitlab Issue API(DELETE) |

Here is the sample of feature file. 

- Feature: Title of your feature
- Background: List of steps run before each of the scenarios
- @tag
- Scenario: Title of your scenario
- Given I want to write a step with precondition
- And some other precondition
- When I complete action
- And some other action
- And yet another action
- Then I validate the outcomes
- And check more outcomes

#### How to add new tests
In order to create a new test, one should create `.feature` file that defines the behaviour of the feature by writing the scenarios and validations of the feature. One can add tags also on just above the scenario to categorize the different scenarios based on their type(For ex: @Positive,@Negative).

#### Project Setup & Test Case Execution

Please follow below steps to set up this project and execute the automated testcases :

1. Clone the project `https://github.com/KarunaDhankani/abn-qa-backend-assingment.git`
2. Provide Username and Password in `/abn-qa-backend-assingment/src/test/java/com/abnamro/assignment/Resources/config.properties` file in order to generate the oauth2 token to use Gitlab Issues API
3. Open terminal in the root directory of the project, where pom.xml is kept
4. Execute command : `mvn clean` and then `mvn test -Dtest=TestRunner`
5. After the successful execution of the testcases, you can find your HTML report `karate-summary.html` under folder `/abn-qa-backend-assingment/target/karate-reports/`

#### Test Automation Report

After the successful execution of all the feature files, the detailed HTML report `karate-summary.html` is generated under folder `/abn-qa-backend-assingment/target/karate-reports/`

Below are the screenshots of how the report looks like:
<details>
<summary>Karate Test Report</summary>

<img width="1275" alt="OverAllFeatures" src="https://user-images.githubusercontent.com/47445151/221467589-27401d85-80b9-4cab-93e1-bac285067080.PNG">
<img width="1270" alt="ListIssue" src="https://user-images.githubusercontent.com/47445151/221467620-5a22f9af-b28e-4d13-84e5-f7032e4e28e3.PNG">
<img width="1271" alt="CreateIssue" src="https://user-images.githubusercontent.com/47445151/221467603-e66ec497-16b7-4189-9626-f3c36409bdcc.PNG">
<img width="1269" alt="UpdateIssue" src="https://user-images.githubusercontent.com/47445151/221467500-df87fed6-e2bf-467b-91e2-03516268065b.PNG">
<img width="1272" alt="DeleteIssue" src="https://user-images.githubusercontent.com/47445151/221467653-149e6c5e-4308-4ab2-921a-901e6e9aade0.PNG">

</details>

#### Refactors done to the given project

1. Removed SampleUnitTest.java file as it was not part of the solution
2. Added required karate dependencies in the pom.xml file
3. Created folder structure `Features\IssuesAPIFeature` under folder `com\abnamro\assignment` folder to keep all the IssuesAPI related files
4. Created `Resources` folder under `com\abnamro\assignment` folder to keep all the json and properties files
5. Created `/abn-qa-backend-assingment/src/test/java/karate-config.js` file to globally set URL for all the features and added connect and read timeout times.
6. Created Java files under Helper and Model Folder to keep the logic for generating oauth2 token.
