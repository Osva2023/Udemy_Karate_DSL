Feature: Create Token

Scenario: Create Token
    Given url 'https://conduit-api.bondaracademy.com/api/'
        Given path 'users/login'
        And request {"user": {"email": "elosvadel84@gmail.com","password": "Osva12345"}}
        When method Post
        Then status 200
        * def authToken = response.user.token
        * print 'INSIDE HELPER - TOKEN VALUE IS >>>', authToken
        * return { authToken: authToken }