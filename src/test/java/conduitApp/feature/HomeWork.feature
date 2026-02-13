
Feature: Home Work

    Background: Preconditions
        * url apiUrl
        * def tokenResult = callonce read('classpath:conduitApp/helpers/CreateToken.feature')
        * def token = tokenResult.authToken
        * def username = tokenResult.username
        * karate.log('=== Logged in user:', username, '===')
    
    @homework
    Scenario: Favorite articles
        # Step 1: Get articles of the personal feed for osvadel84@gmail.com
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        When method Get
        Then status 200   

        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        * def initialFavoritesCount = response.articles[0].favoritesCount
        * def articleSlug = response.articles[0].slug
        
        # Step 3: Make POST request to increse favorites count for the first article
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'favorite'
        And request {}
        When method Post
        Then status 200
        * def currentFavoritesCount = response.article.favoritesCount

        # Step 4: Verify response schema
        * def articleSchema = 
        """
        {
            "id": #number,
            "slug": #string,
            "title": #string,
            "description": #string,
            "body": #string,
            "createdAt": #string,
            "updatedAt": #string,
            "favoritesCount": #number,
            "tagList": #array,
            "author": {
                "username": #string,
                "bio": ##string,
                "image": #string,
                "following": #boolean
            },
            "favorited": #boolean
        }
        """
        And match response.article == articleSchema
        # Step 5: Verify that favorites article incremented by 1
        * match currentFavoritesCount == initialFavoritesCount + 1

        # Step 6: Get all favorite articles
        Given header Authorization = 'Token ' + token
        Given param favorited = username
        Given param limit = 10
        Given param offset = 0
        Given path 'articles'
        When method Get
        Then status 200
        
        
        # Step 7: Verify response schema
        * def articleSchema = 
        """
        {
            "slug": #string,
            "title": #string,
            "description": #string,
            "body": #string,
            "tagList": #array,
            "createdAt": #string,
            "updatedAt": #string,
            "favorited": #boolean,
            "favoritesCount": #number,
            "author": {
                "username": #string,
                "bio": ##string,
                "image": #string,
                "following": #boolean
            }
        }
        """
        And match each response.articles == articleSchema
        
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        * def favoriteArticleSlugs = karate.jsonPath(response, '$.articles[*].slug')   
        * match favoriteArticleSlugs contains articleSlug
        

    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        # Step 2: Get the slug ID for the first arice, save it to variable
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array lentgh and save to variable
            #Example
            * def responseWithComments = [{"article": "first"}, {article: "second"}]
            * def articlesCount = responseWithComments.length
        # Step 6: Make a POST request to publish a new comment
        # Step 7: Verify response schema that should contain posted comment text
        # Step 8: Get the list of all comments for this article one more time
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        # Step 10: Make a DELETE request to delete comment
        # Step 11: Get all comments again and verify number of comments decreased by 1