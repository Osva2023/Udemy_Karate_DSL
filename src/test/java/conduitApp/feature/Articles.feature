@random
Feature: Testing Articles

    Background: Define URL
        # Obtener el token usando el helper
    * def tokenResult = callonce read('classpath:conduitApp/helpers/CreateToken.feature') 
    * def token = tokenResult.authToken
    Given url 'https://conduit-api.bondaracademy.com/api/'
    * def DataGenerator = Java.type('conduitApp.helpers.DataGenerator')

    Scenario: Create a new article
        * def articleData = DataGenerator.getRandomArticleValues()
        * def randomTitle  = articleData.title
        * def randomDescription = articleData.description
        * def randomBody = articleData.body
        * def randomTag = DataGenerator.getRandomTag()
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request 
        """
        { "article": {
            "title": "#(randomTitle)",
            "description": "#(randomDescription)",
            "body": "#(randomBody)",
            "tagList": ["#(randomTag)"]
            }
        }
        """

        When method Post
        Then status 201 
        And match response.article.title == randomTitle
        


    Scenario: Create and delete an article
        * def articleData = DataGenerator.getRandomArticleValues()
        * def randomTitle = articleData.title
        * def randomDescription = articleData.description
        * def randomBody = articleData.body
        * def randomTag = DataGenerator.getRandomTag()
        
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request 
        """
            {
                "article": {
                    "title": "#(randomTitle)",
                    "description": "#(randomDescription)",
                    "body": "#(randomBody)",
                    "tagList": ["#(randomTag)"]
                }
            }
        """
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given header Authorization = 'Token ' + token 
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def createdArticle = response.articles.find(x => x.slug == articleId)
        And match createdArticle != null
        And match createdArticle.title == randomTitle
        And match createdArticle.tagList contains randomTag


        Given header Authorization = 'Token ' + token
        Given path 'articles', articleId
        When method delete
        Then status 204

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def deletedArticle = response.articles.find(x => x.slug == articleId)
        And match deletedArticle == null
        

        