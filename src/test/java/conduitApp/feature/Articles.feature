Feature: Articles

        Background:
            Given url 'https://conduit.productionready.io/api/'

        Scenario: Create a new article
            Given path 'users/login'
              And request {"user": {"email": "karate@user.com", "password": "karate123"}}
             When method Post
             Then status 200

        * def token = response.user.token

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