Feature: Hooks

    Background: hooks
        * def result = call read('classpath:helpers/Dummy.feature')

        # if you use 'callonce', karate will remember the value for the first 'result' object and use this cached value in both scenarios where it is called
        * def result = callonce read('classpath:helpers/Dummy.feature')
        * def username = result.username

    Scenario: First scenario
        * print username
        * print 'First scenario'

    Scenario: Second scenario
        * print username
        * print 'Second scenario'