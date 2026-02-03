Feature: Testing Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        Given path 'users/login'
        And request {"user": {"email": "elosvadel84@gmail.com","password": "Osva12345"}}
        When method Post
        Then status 200
        * def token = response.user.token

    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request { "article": {"title": "The better article ever2","description": "this is a new another again article, nothing important still","body": "weel, keep studying, tedsting again","tagList": ["Slack"]}}
        When method Post
        Then status 201 
        And match response.article.title == 'The better article ever2'
        And match response.article.tagList == ['Slack']


    Scenario: Create and delete an article
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

        