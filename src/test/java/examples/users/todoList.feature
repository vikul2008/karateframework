Feature: All scenarios related to todo list

  Background: Define URL
    #    Calling apiURL from karate-config.js
    Given url apiUrl
    #    ======Calling headers from commonList.feature file=====
    * def headerList = call read('classpath:helpers/commonList.feature')
    * def cookieValue = headerList.headerCookie
    * def contentTypeValue = headerList.headerContentType
    * print '*****Cookie**********************************************'
    * print cookieValue
    * print contentTypeValue
#      =======================================================
    Given header Cookie = cookieValue
    Given header Content-Type = contentTypeValue

  @testTodoList
  Scenario: Get the list of users
    Given path 'todos'
    When method Get
    Then status 200
    And match each response..completed == '#boolean'
    And match each response..userId == '#number'


  @todoData
  Scenario: create a todo list and then get it by id
    Given def postData = {"id": 201}
#    * def timeValidator = read('classpath:helper/timeValidator.js')
    * def NewTodoLst =
    """
      {
    "title": "Sample todo List Title",
    "completed": true,
    "id": #(postData.id)
}
      """

    Given path 'todos'
    And request NewTodoLst
    When method post
    Then status 201

    * def id = response.id
    * print 'created todo list id is: ', id

    And match response ==
    """
    {
    "title": "#string",
    "completed": "#boolean",
    "id": "#number"
    }
    """