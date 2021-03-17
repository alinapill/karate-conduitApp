Feature: Create and delete articles

    Background:
        * url baseUrl
        * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        * def pause = karate.get('__gatling.pause', sleep)
        * def title = __gatling.Title
        * def description = __gatling.Description

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
                            "title": "#(title)",
                            "description": "#(description)",
                            "body": "body"
                          }
                        }
                    """
        When method Post
        Then status 200
        * def articleId = response.article.slug

        # If we specify for example: inject 3 users at once => first it creates 3 articles, then it waits for 5 seconds and only after this pause
        # it goes and deletes the articles set into the PerformanceTest (to mimic real live user interaction)
#        * pause(5000)
#
#        Given header Authorization = 'Token ' + authToken
#        Given path 'articles', articleId
#        When method Delete
#        Then status 200