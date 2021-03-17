Feature: Create articles

    Background:

        * url 'https://conduit.productionready.io/api/'
        * def articleRequestBody = read('classpath:src/test/java/conduitApp/json/newArticleRequest.json')
        * set articleRequestBody.article.title = __gatling.Title
        * set articleRequestBody.article.description = __gatling.Title

    @performance
    Scenario: Create article

        # create token

        Given path 'users/login'
        And request
        """
            {
                "user": {
                    "email": "#(email)",
                    "password": "#(password)"
                }
            }
        """
        When method Post
        Then status 200
        * def authToken = response.user.token

        # create article

        * configure headers = { "Authorization": #('Token ' + __gatling.token) }

        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        * def articleId = response.article.slug
