Feature: Util dummy feature | Hooks

    @HookCallRead
    Scenario: Dummy scenario | Hooks
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def username = dataGenerator.getRandomUsername()
        * print 'Hook using call read'

    @HookCallReadOnce
    Scenario: Dummy scenario | Hooks
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def username = dataGenerator.getRandomUsername()
        * print 'Hook using call read once'

    @HookAfterScenario
    Scenario: Dummy scenario | Hooks
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def username = dataGenerator.getRandomUsername()
        * print 'Hook using afterScenario'

    @HookAfterFeature
    Scenario: Dummy scenario | Hooks
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def username = dataGenerator.getRandomUsername()
        * print 'Hook using afterFeature'