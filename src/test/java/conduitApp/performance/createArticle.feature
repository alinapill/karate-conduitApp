Feature: Create articles

    Background:
        * url baseUrl
        * def articleRequestBody = read('classpath:src/test/java/conduitApp/json/newArticleRequest.json')
        * set articleRequestBody.article.title = __gatling.Title
        * set articleRequestBody.article.description = __gatling.Description

    @performance
    Scenario: Create article
        * configure headers = { "Authorization": #('Token ' + __gatling.token) }

        Given path 'articles'
        And request articleRequestBody
        And header karate-name = 'Create article: ' + __gatling.Title
        When method Post
        Then status 200
        * def articleId = response.article.slug
