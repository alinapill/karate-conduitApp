Feature: Add likes

    Background:
        * url 'https://conduit.productionready.io/api/'
        * def tokenResponse = callonce read('classpath:src/test/java/helpers/CreateToken.feature') { "email": "karate@user.com", "password": "karate123"}
        * def token = tokenResponse.authToken

    Scenario: Add likes
        The result of this request will increase the number of articles
        Given header Authorization = 'Token ' + token
        Given path 'articles', slug, 'favorite'
        # for empty request body, we provide an empty object {}
        And request {}
        When method Post
        And status 200

        * def likesCount = response.article.favoritesCount