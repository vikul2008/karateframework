@testCommentsFeature #Adding tags at feature level
Feature: All scenarios related to comments

  Background: Define URL
    #    Calling apiURL from karate-config.js
    Given url apiUrl
    #    ======Calling headers from commonList.feature file=====
    * def commonListData = call read('classpath:helpers/commonList.feature')
    * def cookieValue = commonListData.headerCookie
    * def contentTypeValue = commonListData.headerContentType
    * def dataGeneratorValue = commonListData.dataGenerator
    * def randomEmail = dataGeneratorValue.getRandomEmail()
    * print '*****Cookie**********************************************'
    * print cookieValue
    * print contentTypeValue
#      =======================================================
    Given header Cookie = cookieValue
    Given header Content-Type = contentTypeValue


  Scenario: Get the list of albums
    Given path 'comments'
    When method Get
    Then status 200
    * print '**************'
    * print 'headers:'
    * print responseTime
    Then assert responseTime < 2000

  @testCommentsPost
  Scenario: write a comment and then get it by id
    Given path 'comments'
    Given def commentsData = {"postId": 200}
    * def commentsRequestBody =
      """
      {
        "postId": #(commentsData.postId),
        "name": "id labore ex et quam laborum",
        "email": "#(randomEmail)",
        "body": "My Test comment"
      }
      """
    And request commentsRequestBody
    When method post
    Then status 201

    * def id = response.id
    * print 'created new user id is: ', id

And match response ==
    """
    {
    "postId": "#(commentsData.postId)",
    "name": "#string",
    "email": "#(randomEmail)",
    "body": "#string",
    "id": "#number"
}
    """

