Feature: All scenarios related to albums

  Background: Define URL
    #    Calling apiURL from karate-config.js
    * url apiUrl
    # Reading the request from json file
    * def albumsRequest = read('classpath:examples/jsonFiles/commonRequests.json')
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

  Scenario: Get the list of albums
    Given path 'albums'
    When method Get
    Then status 200
    * print '**************'
    * print 'headers:'
    * print responseTime
    Then assert responseTime < 2000

  @testAlbums
  Scenario: create an album and then get it by id
    Given path 'albums'
    And request albumsRequest
    When method post
    Then status 201

    * def id = response.id
    * print 'created new user id is: ', id
    And match response ==
    """
    {
    "userId": "#number",
    "title": "#string",
    "id": "#number"
    }
    """

