
Feature: Test for the aplication home page

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
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
        And match response.articles == '#[10]' 
        And match response.articlesCount == 10  

   