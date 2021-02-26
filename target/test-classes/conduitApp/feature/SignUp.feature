Feature: Sign up a new user

    Background:
        Given url 'https://conduit.productionready.io/api/'
#        Given url baseUrl
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('../../helpers/timeValidator.js')

        # embedded expressions | multiline expressions
    Scenario: Create a new user | Sign up

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        Given path 'users'
        And request
                    """
                        {
                            "user": {
                                "email": #(randomEmail),
                                "password": "karate2121",
                                "username": #(randomUsername)
                            }
                        }
                    """
        When method Post
        Then status 200
        And match response ==
        ## replace with fuzzy matching and schema validation patterns
        """
            {
                "user": {
                    "id": #number,
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUsername),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """

    Scenario: Create a new user | Sign up - using a JS function to create an instance of the JAVA file

        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        * def jsFunction =
        """
            function() {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                
            }
        """


        Given path 'users'
        And request
                    """
                        {
                            "user": {
                                "email": #(randomEmail),
                                "password": "karate2121",
                                "username": #(randomUsername)
                            }
                        }
                    """
        When method Post
        Then status 200
        And match response ==
        ## replace with fuzzy matching and schema validation patterns
        """
            {
                "user": {
                    "id": #number,
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUsername),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """
