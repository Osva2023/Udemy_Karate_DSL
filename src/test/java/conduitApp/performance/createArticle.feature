
Feature: Testing Articles

    Background: Define URL
        # Obtener el token usando el helper
    * def tokenResult = callonce read('classpath:conduitApp/helpers/CreateToken.feature') 
    * def token = tokenResult.authToken
    Given url 'https://conduit-api.bondaracademy.com/api/'
    * def DataGenerator = Java.type('conduitApp.helpers.DataGenerator')
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('_gatling.pause', sleep)

    Scenario: Create and delete an article
        # Get feeder data from Gatling (Title and Description from CSV)
        * def feedTitle = __gatling.Title
        * def feedDescription = __gatling.Description
        
        # Use feeder data or fall back to DataGenerator
        * def randomTitle = feedTitle != null ? feedTitle : DataGenerator.getRandomArticleValues().title
        * def randomDescription = feedDescription != null ? feedDescription : DataGenerator.getRandomArticleValues().description
        * def randomBody = DataGenerator.getRandomArticleValues().body
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

        * pause(5000) 

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
        

        