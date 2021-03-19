@functional
Feature: Sign up a new user

    Background:
        * url baseUrl
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('../../helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()

        # embedded expressions | multiline expressions
    Scenario: Create a new user | Sign up
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
        # replace with fuzzy matching and schema validation patterns
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

        # jsFunction variable is the entry point to the JS function
        * def jsFunction =
        """
            function() {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsernameNonStaticMethod()
            }
        """

        * def randomUser2 = call jsFunction

        Given path 'users'
        And request
                    """
                        {
                            "user": {
                                "email": #(randomEmail),
                                "password": "karate2121",
                                "username": #(randomUser2)
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
                    "username": #(randomUser2),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """

    Scenario Outline: Validate sign up | Error messages
        Given path 'users'
        And request
                    """
                        {
                            "user": {
                                "email": "<email>",
                                "password": "<password>",
                                "username": <username>
                            }
                        }
                    """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                | password  | username          | errorResponse                                        |
            | #(randomEmail)       | Karate123 | KarateUser123     | {"errors": {"username": ["has already been taken"]}} |
            | KarateUser1@test.com | Karate123 | #(randomUsername) | {"errors": {"email": ["has already been taken"]}}    |
            |                      | Karate123 | #(randomUsername) | {"errors": {"email": ["can't be blank"]}}            |