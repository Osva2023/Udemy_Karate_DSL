@newtag
Feature: Sign up new Users

Background:
    Given url apiUrl
    * def DataGenerator = Java.type('conduitApp.helpers.DataGenerator')
Scenario: New User sign up
    * def randomUsername = DataGenerator.getRandomUsername()
    * def randomEmail = DataGenerator.getRandomEmail()
    Given path 'users'
    Given def userData = 
        """
        {
            "user": {
                "username": "#(randomUsername)",
                "email": "#(randomEmail)",
                "password": "password123"
            }
        }
        """
    And request userData
    When method post
    Then status 201
    And match response.user.username == userData.user.username
    And match response.user.email == userData.user.email

Scenario Outline: Validate Sign Up error messages
    * def randomUsername = DataGenerator.getRandomUsername()
    * def randomEmail = DataGenerator.getRandomEmail()
    Given path 'users'
    Given def userData = 
        """
        {
            "user": {
                "username": "<username>",
                "email": "<email>",
                "password": "<password>"
            }
        }
        """
    And request userData

    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
    | username                        | email                | password    | errorResponse                                                     |
    |#(randomUsername)                | KarateUser1@test.com | Karate123   |{"errors":{"email":["has already been taken"]}}                    |
    |cualquiera                       | #(randomEmail)       | Karate123   |{"errors":{"username":["has already been taken"]}}                 |
    |#(randomUsername)                | emailwithout         | Karate123   |{"errors":{"email":["is invalid"]}}                                |
    |osvaldolafigura23458373646475757 | #(randomEmail)       | Karate123   | {"errors":{"username":["is too long (maximum is 20 characters)"]}}|
    |#(randomUsername)                |#(randomEmail)        |Kar          |{"errors":{"password":["is too short (minimum is 8 characters)"]}} |
