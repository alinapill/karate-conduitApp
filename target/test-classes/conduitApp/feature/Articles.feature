Feature: Articles

    Background:
        Given url 'https://conduit.productionready.io/api/'
        * def tokenResponse = callonce read('../../helpers/CreateToken.feature@CreateToken') { "email": "karate@user.com", "password": "karate123"}
        * def token = tokenResponse.authToken

    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request
                    """
                        {
                          "article": {
                            "tagList": [
                            ],
                            "title": "Bla bla",
                            "description": "test test",
                            "body": "body"
                          }
                        }
                    """
        When method Post
        Then status 200
        And match response.article.title == 'Bla bla'

    Scenario: Create and Delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request
                    """
                        {
                          "article": {
                            "tagList": [
                            ],
                            "title": "Delete test",
                            "description": "test test",
                            "body": "body"
                          }
                        }
                    """
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete test'

        Given header Authorization = 'Token ' + token
        Given path 'articles', articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete test'