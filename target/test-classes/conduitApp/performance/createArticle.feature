
Feature: Testing Articles

    Background: Define URL
        # Get token from Gatling feeder or create one for regular tests
        * def isGatling = karate.get('__gatling') != null
        * if (!isGatling) karate.callSingle('classpath:conduitApp/helpers/CreateToken.feature')
        * def token = isGatling ? __gatling.token : karate.get('authToken')
        * print '=== TOKEN BEING USED:', token ? token.substring(0, 30) + '...' : 'NULL', '==='
        Given url 'https://conduit-api.bondaracademy.com/api/'
        * def DataGenerator = Java.type('conduitApp.helpers.DataGenerator')
        * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        * def pause = karate.get('_gatling.pause', sleep)

    Scenario: Create and delete an article
        # Get feeder data from Gatling (only when running under Gatling)
        * def feedTitle = isGatling ? __gatling.Title : null
        * def feedDescription = isGatling ? __gatling.Description : null
        * print '=== USING TITLE:', feedTitle, 'DESCRIPTION:', feedDescription, '==='
        
        # Make titles unique by appending timestamp
        * def timestamp = new Date().getTime()
        * def uniqueSuffix = '-' + timestamp
        
        # Use feeder data if available, otherwise use DataGenerator
        * def articleData = feedTitle == null ? DataGenerator.getRandomArticleValues() : null
        * def randomTitle = feedTitle != null ? feedTitle + uniqueSuffix : articleData.title
        * def randomDescription = feedDescription != null ? feedDescription : articleData.description
        * def randomBody = articleData != null ? articleData.body : DataGenerator.getRandomArticleValues().body
        * def randomTag = DataGenerator.getRandomTag()
        * print '=== FINAL UNIQUE TITLE:', randomTitle, '==='
        
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
        * print '=== ARTICLE CREATED with ID:', articleId, '==='

        Given header Authorization = 'Token ' + token 
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * print '=== GET ARTICLES response received ==='
        * def createdArticle = response.articles.find(x => x.slug == articleId)
        * print '=== FOUND ARTICLE:', createdArticle, '==='
        And match createdArticle != null
        And match createdArticle.title == randomTitle
        And match createdArticle.tagList contains randomTag
        * print '=== VERIFICATION COMPLETE ==='

        * pause(5000) 

        Given header Authorization = 'Token ' + token
        Given path 'articles', articleId
        When method delete
        Then status 204
        * print '=== ARTICLE DELETED ==='

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def deletedArticle = response.articles.find(x => x.slug == articleId)
        And match deletedArticle == null
        * print '=== DELETE VERIFICATION COMPLETE ==='
        

        