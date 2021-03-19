Feature: Create token

    Scenario: Create token

        * url baseUrl
        And path 'users/login'
        And request {"user": {"email": "#(email)", "password": "#(password)"}}
        When method Post
        Then status 200

        * def authToken = response.user.token