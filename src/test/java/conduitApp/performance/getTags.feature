Feature: Tests for the HomePage
    This test is used as load in gatling simulations

    Background:
        Given url 'https://conduit.productionready.io/api/'

    @performance
    Scenario: Get all tags

        Given path 'tags'
        When method Get
        Then status 200