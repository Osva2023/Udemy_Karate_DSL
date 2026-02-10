
Feature: Test for the aplication home page

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        * def timeValidator = read('classpath:conduitApp/helpers/timeValidator.js')

    Scenario: Get all Tags 
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['Blog','Zoom']
        And match response.tags !contains 'truck'
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
    
        Given params { limit: 10, offset: 0}
        #le doy los paramettros en un objeto con un array, en vez d euno a uno
        Given path 'articles'
        When method Get
        Then status 200
        * def articleSchema = 
        """  
        {
            slug: '#string',
            title: '#string',
            description: '#string',
            body: '#string',
            tagList: '#array',
            createdAt: '#? timeValidator(_)',
            updatedAt: '#? timeValidator(_)',
            favorited: '#boolean',
            favoritesCount: '#number',
            author: {
                username: '#string',
                bio: '##string',
                image: '#string',
                following: '#boolean'
            }
        }
        """
        And match each response.articles == articleSchema
        And match response.articlesCount == 10
   