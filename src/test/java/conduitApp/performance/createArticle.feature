Feature: Create and delete articles

    Background:
        * url baseUrl

    @performance
    Scenario: Create and Delete article | hardcoded values | using JSON request body file
        Given path 'users/login'
        And request
        """
            {
                "user": {
                    "email": "karate@user.com",
                    "password": "karate123"
                }
            }
        """
        When method Post
        Then status 200
        * def authToken = response.user.token

        Given header Authorization = 'Token ' + authToken
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

        Given header Authorization = 'Token ' + authToken
        Given path 'articles', articleId
        When method Delete
        Then status 200