Feature: Create Token

Scenario: Generate auth token
  Given url 'https://conduit-api.bondaracademy.com/api/'
  Given path 'users/login'
  And request { "user": { "email": "#(userEmail)", "password": "#(userPassword)"}}
  When method Post
  Then status 200
  * def authToken = response.user.token
  * def username = response.user.username
  * print 'INSIDE HELPER - TOKEN IS >>>', authToken
  * print 'INSIDE HELPER - USERNAME IS >>>', username
