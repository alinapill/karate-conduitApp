Feature: Tests for the HomePage

    Background:
        Given url 'https://conduit.productionready.io/api/'

    Scenario: Get all tags

        Given path 'tags'
        When method Get
        Then status 200

        And match response.tags contains ['Gandhi', 'test']
        And match response.tags !contains ['truck']
        And match response.tags contains any ['dragons', 'test', 'Hitler']
        And match response.tags !contains any ['dragons1', 'test1', 'Hitler1']

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
        And match response.articlesCount != 100
        # assert response objects
        And match response == {"articles": "#array", "articlesCount": 500 }
        And match response.articles[0].createdAt contains '2021'

        # (*) is a wildcard in karate (karate looks at all values of the array |   at least one bio is null)
        And match response.articles[*].author.bio contains null

        # shortcut to get the values of the object/array using (..)
        And match each response..following == false
        And match each response..following == '#boolean'
        And match each response..favouritesCount == '#number'

        # (##) null or String
        And match each response..bio == '##string'

        # schema validation
        And match response.articles ==
        """
             {
                        "title": "#string",
                        "slug": "#string",
                        "body": "#string",
                        "createdAt": "2021-02-25T13:40:12.141Z",
                        "updatedAt": "2021-02-25T13:40:12.141Z",
                        "tagList": "#array",
                        "description": "#string",
                        "author": {
                            "username": "#string",
                            "bio": "##string",
                            "image": "#string",
                            "following": #boolean
                        },
                        "favorited": #boolean,
                        "favoritesCount": #number
            }
        """
