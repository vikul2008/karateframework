Feature: All scenarios related to users


  Background: Define URL
    #    Calling apiURL from karate-config.js
    Given url apiUrl
#    ======Calling headers and data generator from commonList.feature file=====
    * def commonListData = call read('classpath:helpers/commonList.feature')
    * def cookieValue = commonListData.headerCookie
    * def contentTypeValue = commonListData.headerContentType
    * def dataGeneratorValue = commonListData.dataGenerator
    * def randomEmail = dataGeneratorValue.getRandomEmail()
    * def randomUserName = dataGeneratorValue.getRandomUsername()
    * print '*****Cookie**********************************************'
    * print cookieValue
    * print contentTypeValue
#      =======================================================
    Given header Cookie = cookieValue
    Given header Content-Type = contentTypeValue

  @testUsers
  Scenario: Get the list of users
    * configure retry = {count: 10, interval: 5000}
    * def sleep = function(pause){java.lang.Thread.sleep(pause)}
    Given path 'users'
    When method Get
    Then status 200
    * eval sleep (5000)
    And match response == '#[10]'
    And match each response..email contains '@'
    * print '**************'
    * print 'headers:'
    * print responseTime
    And retry until responseTime < 1000
    Then assert responseTime < 1000

  @testUsersFilter
  Scenario: Get the user details based on id and username
#    Calling params from karate-config.js
    Given params {id:#(id),username:#(username)}
    Given path 'users'
    When method Get
    Then status 200
    And match response.[0].id == 5
    And match response.[0].username == 'Kamren'

  @getUserByID
  Scenario: create a user and then get it by id
    * def Newuser =
"""
      {
        "name": "Test User",
        "username": #(randomUserName),
        "email": "#(randomEmail)",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given path 'users'
    And request Newuser
    When method post
    Then status 201

    * def id = response.id
    * print 'created new user id is: ', id

    And match response ==
  """
  {
    "name": "#string",
    "username": "#(randomUserName)",
    "email": "#(randomEmail)",
    "address": {
        "street": "#string",
        "suite": "Apt. 123",
        "city": "#string",
        "zipcode": "54321-6789"
    },
    "id": "#number"
}
  """

