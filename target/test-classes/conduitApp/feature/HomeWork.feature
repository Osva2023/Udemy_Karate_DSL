
Feature: Home Work

    Background: Preconditions
        * url apiUrl
        * def tokenResult = callonce read('classpath:conduitApp/helpers/CreateToken.feature')
        * def token = tokenResult.authToken
        * def username = tokenResult.username
        * karate.log('=== Logged in user:', username, '===')
        * def DataGenerator = Java.type('conduitApp.helpers.DataGenerator')
        * def randomCommentBody = DataGenerator.getRandomComment()
    
    
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
        
    @homework
    Scenario: Comment articles
        # Step 1: Get atricles of the global feed
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        Given param limit = 10
        Given param offset = 0
        When method Get
        Then status 200
        # Step 2: Get the slug ID for the first arice, save it to variable
        * def articleSlug = response.articles[0].slug

        # Step 3: Make a GET call to 'comments' end-point to get all comments
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'comments'
        When method Get
        Then status 200

        # Step 4: Verify response schema
        * def commentSchema = 
        """
        {
            "id": #number,
            "createdAt": #string,
            "updatedAt": #string,
            "body": #string,
            "author": {
                "username": #string,
                "bio": ##string,
                "image": #string,
                "following": #boolean
            }
        }
        """
        And match each response.comments == commentSchema
        * def initialCommentsCount = response.comments.length
        * karate.log('=== Initial comments count:', initialCommentsCount, '===')
        # Step 6: Make a POST request to publish a new comment

        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'comments'
        And request { "comment": { "body": "#(randomCommentBody)" } }
        When method Post
        Then status 200
        * def postedCommentResponse = 
        """
    {
        "id": #number,
        "createdAt": #string,
        "updatedAt": #string,
        "body": #string,
        "author": {
            "username": #string,
            "bio": null,
            "image": "https://conduit-api.bondaracademy.com/images/smiley-cyrus.jpeg",
             "following": false         }
    }
    """
        And match response.comment == postedCommentResponse

        # Step 7: Verify response schema that should contain posted comment text
        And match response.comment.body == randomCommentBody


        # Step 8: Get the list of all comments for this article one more time
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'comments'
        When method Get
        Then status 200

        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        * def afterCommentsCount = response.comments.length
        And match afterCommentsCount == initialCommentsCount + 1

        # Step 10: Make a DELETE request to delete comment
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'comments', response.comments[0].id
        When method Delete
        Then status 200

        # Step 11: Get all comments again and verify number of comments decreased by 1
        Given header Authorization = 'Token ' + token
        Given path 'articles', articleSlug, 'comments'
        When method Get
        Then status 200
        * def finalCommentsCount = response.comments.length
        And match finalCommentsCount == initialCommentsCount
