@functional
Feature: Articles

    Background:
        * url baseUrl
        * def tokenResponse = callonce read('classpath:src/test/java/helpers/CreateToken.feature') { "email": "karate@user.com", "password": "karate123"}
        * def token = tokenResponse.authToken
        # call JSON object, assign this Json into this object, call: articleRequestBody.article.title-description-body, assign to these values - the generated values
        * def articleRequestBody = read('classpath:src/test/java/conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')

        * set articleRequestBody.article.title = dataGenerator.getRandomArticlesValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticlesValues().title
        * set articleRequestBody.article.title = dataGenerator.getRandomArticlesValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticlesValues().body

    Scenario: Create a new article | hardcoded values
        Given header Authorization = 'Token ' + token
        And path 'articles'
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

    Scenario: Create a new article | using dynamic values - dataGenerated values
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        And match response.article.title == articleRequestBody.article.title

    Scenario: Create a new article | data generated values
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        And match response.article.title == articleRequestBody.article.title

    Scenario: Create and Delete article | hardcoded values | using JSON request body file
        Given header Authorization = 'Token ' + token
        And path 'articles'
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
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete test'

        Given header Authorization = 'Token ' + token
        And path 'articles', articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0 }
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title