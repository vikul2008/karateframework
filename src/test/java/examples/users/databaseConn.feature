@ignore
Feature: Database Scenarios

  Background: Connect to DB
    * def dbHandler = Java.type('helpers.DBHandler')

    Scenario: Send database with a new job
      * eval dbHandler.addNewJobWithName("QA5")

      Scenario: Fetch data from DB for jobs
        * def level = dbHandler.getMinAndMaxLevelsForJob("Publisher")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '50'
        And match level.maxLvl == '80'
