@parallel=false
Feature: Hooks | using 'callonce'
    This feature is using 'callonce'
    If you use 'callonce', karate will remember the value for the first 'result' object and use this cached value in both scenarios where it is called
    'before' hooks are setup in 'Background' section and they run *before* each scenario
    'afterScenario' and 'afterFeature' hooks are setup in 'Background' section and they run *after* each scenario

    Background:
        * def result = callonce read('classpath:helpers/HooksUtilFile.feature@HookCallReadOnce')
        * def username = result.username

        # using in-line JS function
        * configure afterScenario = function(){ karate.call('classpath:helpers/HooksUtilFile.feature@HookAfterScenario') }

        # using embedded expression
        * configure afterFeature =
        """
            function(){
                karate.call('classpath:helpers/HooksUtilFile.feature@HookAfterFeature');
                }
        """

    Scenario: First scenario
        * print 'username: ', username
        * print 'This is the first scenario'

    Scenario: Second scenario
        * print 'username: ', username
        * print 'This is the second scenario'