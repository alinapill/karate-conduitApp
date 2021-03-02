Feature: Hooks | using 'call'
    This feature is using 'call'
    If you use 'call', karate will generate the value for the 'result' object for each of these scenarios

    Background:
        * def result = call read('classpath:helpers/HooksUtilFile.feature@HookCallRead')
        * def username = result.username

    Scenario: First scenario
        * print 'username: ', username
        * print 'This is the first scenario'

    Scenario: Second scenario
        * print 'username: ', username
        * print 'This is the second scenario'