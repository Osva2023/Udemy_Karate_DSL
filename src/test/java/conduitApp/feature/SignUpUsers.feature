@newtag
Feature: Sign up new Users

Background:
    Given url apiUrl
Scenario: New User sign up
    Given path 'users'
    Given def userData = 
        """
        {
            "user": {
                "username": "greysonuser",
                "email": "greysonuser@example.com",
                "password": "password123"
            }
        }
        """
    And request userData
    When method post
    Then status 201
    And match response.user.username == userData.user.username