
Feature: Testing Articles

    Background: Define URL
        # Obtener el token usando el helper
    * def tokenResult = callonce read('classpath:conduitApp/helpers/CreateToken.feature') 
    * def token = tokenResult.authToken
    * print 'TOKEN FINAL >>>', token
    Given url 'https://conduit-api.bondaracademy.com/api/'
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request { "article": {"title": "The better article ever45","description": "this is a new another again article, nothing important still","body": "weel, keep studying, tedsting again","tagList": ["Slack"]}}
        When method Post
        Then status 201 
        And match response.article.title == 'The better article ever45'
        And match response.article.tagList == ['Slack']

@debug
    Scenario: Create and delete an article
        * print 'TOKEN VALUE IS >>>', token
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request { "article": {"title": "Article for delete","description": "testing how to create and delete","body": "delete it baby","tagList": ["Slack"]}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given header Authorization = 'Token ' + token 
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Article for delete'

        Given header Authorization = 'Token ' + token
        Given path 'articles', articleId
        When method delete
        Then status 204

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Article for delete'

        