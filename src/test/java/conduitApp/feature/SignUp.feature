Feature: Sign up a new user

    Background:
        Given url 'https://conduit.productionready.io/api/'

        # embedded expressions | multiline expressions
    Scenario: Create a new user | Sign up
        Given def userData = {"email":"KarateUser224@user.com","username":"KarateUser224"}
        Given path 'users'
        And request
                    """
                        {
                            "user": {
                                "email": #('Test' + userData.email),
                                "password": "karate21343",
                                "username": #('User' + userData.username)
                            }
                        }
                    """
        When method Post
        Then status 200

