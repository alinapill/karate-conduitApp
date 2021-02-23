Feature: Tests for the HomePage

    Background:
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['Gandhi', 'test']
        And match response.tags !contains ['truck']
             # fuzzy validation
        And match response.tags ==  "#array"
        And match each response.tags ==  "#string"

    Scenario: Get 10 articles from the page
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 500