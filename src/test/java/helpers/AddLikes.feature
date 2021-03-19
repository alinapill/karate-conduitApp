Feature: Add likes

    Background:
        * url baseUrl
        * def tokenResponse = callonce read('classpath:src/test/java/helpers/CreateToken.feature') { "email": "karate@user.com", "password": "karate123"}
        * def token = tokenResponse.authToken

    Scenario: Add likes
        The result of this request will increase the number of articles

        Given header Authorization = 'Token ' + token
        And path 'articles', slug, 'favorite'
        # for empty request body, we provide an empty object {}
        And request {}
        When method Post
        Then status 200

        * def likesCount = response.article.favoritesCount