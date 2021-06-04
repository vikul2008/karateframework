Feature: List of common things that can be fetched in the project

  Scenario: Enter the header details here
    * def headerCookie = '__cfduid=de9bc179817ee648bce235fb063d1ac701620403151'
    * def headerContentType = 'application/json'
    * def dataGenerator = Java.type('helpers.dataGenerator')

#  @conversionLogic
#  Scenario: Number to string conversion logic
#    * def numVal = 10
#    * def json = {"strVal": #(numVal+'')}
#    * match json == {"strVal": '10'}
#
#  @conversionLogic
#  Scenario: String to string conversion logic
#    * def strVal = '10'
#    * def json = {"numVal": #(~~parseInt(strVal))}
#    * match json == {"numVal": 10}