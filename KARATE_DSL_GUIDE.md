# Karate DSL - Complete Guide

## 📚 Table of Contents
1. [What is Karate DSL?](#what-is-karate-dsl)
2. [Key Features](#key-features)
3. [Getting Started](#getting-started)
4. [Core Concepts](#core-concepts)
5. [Most Used Keywords & Actions](#most-used-keywords--actions)
6. [Common Patterns](#common-patterns)
7. [Advanced Features](#advanced-features)
8. [Performance Testing with Gatling](#performance-testing-with-gatling)
9. [Best Practices](#best-practices)
10. [Official Resources](#official-resources)

---

## What is Karate DSL?

**Karate** is an open-source tool that combines API test automation, mocks, performance testing, and UI automation into a single, unified framework. It uses a Gherkin-like syntax (BDD) but doesn't require any programming knowledge to write tests.

### Why Karate?
- ✅ **No need for Java/programming knowledge** - Pure DSL
- ✅ **Built on Cucumber/Gherkin** - Business-readable tests
- ✅ **Rich assertions** - JSON, XML, GraphQL support
- ✅ **Parallel execution** - Fast test runs
- ✅ **Performance testing** - Integrated with Gatling
- ✅ **UI automation** - Built-in browser automation
- ✅ **Mock server** - Create test doubles easily

---

## Key Features

### 1. **API Testing**
- REST, SOAP, GraphQL
- JSON & XML assertions
- Schema validation
- File upload/download

### 2. **Data-Driven Testing**
- CSV, JSON, Excel data sources
- Dynamic data generation
- Parameterized tests

### 3. **Performance Testing**
- Gatling integration
- Load testing scenarios
- Real-time metrics

### 4. **UI Automation**
- Browser automation (Chrome, Firefox, Safari)
- Web scraping
- Cross-browser testing

### 5. **Test Doubles**
- Mock servers
- Service virtualization
- Contract testing

---

## Getting Started

### Maven Dependency
```xml
<dependency>
    <groupId>com.intuit.karate</groupId>
    <artifactId>karate-junit5</artifactId>
    <version>1.4.1</version>
    <scope>test</scope>
</dependency>
```

### Basic Project Structure
```
src/test/java
├── karate-config.js          # Global configuration
├── yourpackage/
│   ├── YourTest.java         # JUnit test runner
│   └── feature/
│       └── your-test.feature # Test scenarios
```

### Simple Test Runner
```java
import com.intuit.karate.junit5.Karate;

class TestRunner {
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:yourpackage").relativeTo(getClass());
    }
}
```

---

## Core Concepts

### 1. **Feature Files** (`.feature`)
Test scenarios written in Gherkin syntax.

```gherkin
Feature: User API Testing

  Background:
    * url 'https://api.example.com'
    * header Content-Type = 'application/json'

  Scenario: Create a new user
    Given path 'users'
    And request { name: 'John', email: 'john@test.com' }
    When method POST
    Then status 201
    And match response.name == 'John'
```

### 2. **karate-config.js**
Global configuration for all tests.

```javascript
function fn() {
  var env = karate.env; // Get environment variable
  karate.log('karate.env:', env);
  
  var config = {
    baseUrl: 'https://api.example.com',
    apiKey: 'your-api-key'
  };
  
  if (env === 'dev') {
    config.baseUrl = 'https://dev.api.example.com';
  } else if (env === 'prod') {
    config.baseUrl = 'https://prod.api.example.com';
  }
  
  return config;
}
```

### 3. **Variables & Expressions**
```gherkin
# Define variables
* def username = 'john@test.com'
* def baseUrl = 'https://api.example.com'

# JavaScript expressions
* def randomId = Math.floor(Math.random() * 1000)
* def fullName = firstName + ' ' + lastName

# Embedded expressions in JSON
And request { "email": "#(username)" }
```

---

## Most Used Keywords & Actions

### HTTP Methods
```gherkin
# Basic HTTP operations
Given url 'https://api.example.com'
And path 'users', userId
When method GET
Then status 200

# Other methods: POST, PUT, PATCH, DELETE, HEAD, OPTIONS
When method POST
When method PUT
When method DELETE
```

### Request Configuration
```gherkin
# Headers
Given header Authorization = 'Bearer ' + token
And header Content-Type = 'application/json'
And headers { Accept: 'application/json', User-Agent: 'Karate' }

# Query parameters
Given param search = 'John'
And param limit = 10
And params { page: 1, sort: 'asc' }

# Request body
And request { "name": "John", "age": 30 }
And request read('data/user.json')

# Form fields
And form field username = 'john'
And form field password = 'secret'

# Multipart (file upload)
And multipart field file = read('document.pdf')
And multipart file myFile = { read: 'data.csv', filename: 'test.csv', contentType: 'text/csv' }
```

### Assertions
```gherkin
# Status code
Then status 200
And status 201

# Response matching
And match response == { id: '#number', name: 'John' }
And match response.email == 'john@test.com'
And match response contains { name: 'John' }
And match response.items == '#[5]'  # Array with 5 elements

# Fuzzy matching (schema validation)
And match response == 
"""
{
  id: '#number',
  name: '#string',
  email: '#regex ^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$',
  active: '#boolean',
  roles: '#array',
  profile: '#object',
  optional: '##string'  # Optional field
}
"""

# NOT matching
And match response.name != 'Jane'
And match response !contains { deleted: true }

# Array assertions
And match each response.users == { id: '#number', name: '#string' }
And match response.users[0].name == 'John'
```

### Variable Assignment
```gherkin
# From response
* def userId = response.id
* def token = response.token

# From header
* def location = responseHeaders['Location'][0]

# JSON path
* def firstUser = response.users[0]
* def allNames = response.users[*].name

# Conditional assignment
* def role = karate.get('response.role', 'guest')
```

### Control Flow
```gherkin
# If-else
* if (responseStatus == 200) karate.set('success', true)

# JavaScript block
* eval
"""
if (response.status === 'active') {
  karate.set('message', 'User is active');
} else {
  karate.set('message', 'User is inactive');
}
"""
```

### Calling Other Features
```gherkin
# Call another feature
* def result = call read('classpath:helpers/create-token.feature')
* def token = result.authToken

# Call with parameters
* def result = call read('create-user.feature') { name: 'John', email: 'john@test.com' }

# Call once (shared across scenarios)
* def tokenResult = callonce read('get-token.feature')
```

### Retry & Wait
```gherkin
# Retry until condition is met
* retry until response.status == 'completed'
Given path 'jobs', jobId
When method GET

# Wait/pause
* def sleep = function(ms){ java.lang.Thread.sleep(ms) }
* call sleep 2000  # Wait 2 seconds
```

---

## Common Patterns

### 1. **Authentication Token Pattern**
```gherkin
Feature: Get Auth Token

Scenario: Login and get token
  Given url baseUrl
  And path 'auth/login'
  And request { username: '#(username)', password: '#(password)' }
  When method POST
  Then status 200
  * def authToken = response.token
```

Usage:
```gherkin
Background:
  * def tokenResult = callonce read('classpath:helpers/get-token.feature')
  * def token = tokenResult.authToken
  * header Authorization = 'Bearer ' + token
```

### 2. **Data-Driven Testing**
```gherkin
Scenario Outline: Create users with different data
  Given path 'users'
  And request { name: '<name>', email: '<email>' }
  When method POST
  Then status 201

  Examples:
    | name  | email             |
    | John  | john@test.com     |
    | Jane  | jane@test.com     |
    | Bob   | bob@test.com      |
```

### 3. **Reading External Data**
```gherkin
# JSON file
* def users = read('data/users.json')

# CSV file
* def testData = read('data/test-data.csv')

# Iterate over data
* def createUser = 
"""
function(user) {
  return karate.call('create-user.feature', user);
}
"""
* def results = karate.map(users, createUser)
```

### 4. **Dynamic Data Generation**
```gherkin
# Java utility class
* def DataGenerator = Java.type('helpers.DataGenerator')
* def randomEmail = DataGenerator.getRandomEmail()
* def randomName = DataGenerator.getRandomName()

# JavaScript
* def uuid = function(){ return java.util.UUID.randomUUID() + '' }
* def uniqueId = uuid()
* def timestamp = new Date().getTime()
```

### 5. **Schema Validation**
```gherkin
# Define schema
* def userSchema = 
"""
{
  id: '#number',
  username: '#string',
  email: '#regex ^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$',
  active: '#boolean',
  createdAt: '#string',
  profile: {
    firstName: '#string',
    lastName: '#string',
    age: '#number? _ > 0 && _ < 150'
  }
}
"""

# Validate
And match response == userSchema
```

---

## Advanced Features

### 1. **Parallel Execution**
```java
@Test
void testParallel() {
    Results results = Runner.path("classpath:features")
        .outputCucumberJson(true)
        .parallel(5);  // 5 threads
    assertTrue(results.getFailCount() == 0);
}
```

### 2. **Custom Configuration**
```gherkin
# Set config at runtime
* configure headers = { 'Custom-Header': 'value' }
* configure connectTimeout = 5000
* configure readTimeout = 5000
* configure retry = { count: 3, interval: 1000 }
* configure ssl = true
```

### 3. **File Upload**
```gherkin
# Simple file upload
Given path 'upload'
And multipart file myFile = { read: 'test.pdf', filename: 'document.pdf' }
When method POST

# Multiple files
And multipart file file1 = { read: 'file1.txt' }
And multipart file file2 = { read: 'file2.txt' }
And multipart field description = 'Multiple files upload'
```

### 4. **GraphQL**
```gherkin
Given url 'https://api.example.com/graphql'
And request 
"""
{
  query: '{ user(id: "#(userId)") { id name email } }'
}
"""
When method POST
Then status 200
And match response.data.user.name == 'John'
```

### 5. **WebSocket**
```gherkin
* def socket = karate.webSocket('ws://echo.websocket.org')
* socket.send('hello')
* def result = socket.listen(5000)
* match result == 'hello'
```

---

## Performance Testing with Gatling

### 1. **Scala Simulation Class**
```scala
import com.intuit.karate.gatling.javaapi.KarateDsl._
import io.gatling.javaapi.core.CoreDsl._
import io.gatling.javaapi.core.Simulation

class PerfTest extends Simulation {
  
  val protocol = karateProtocol()
  protocol.runner.karateEnv("perf")
  
  val createUser = scenario("Create Users")
    .exec(karateFeature("classpath:features/create-user.feature"))
  
  setUp(
    createUser.injectOpen(
      rampUsers(100).during(60)  // 100 users over 60 seconds
    ).protocols(protocol)
  )
}
```

### 2. **Load Testing Patterns**
```scala
// Immediate spike
atOnceUsers(100)

// Gradual ramp-up
rampUsers(100).during(60)

// Constant rate
constantUsersPerSec(10).during(120)

// Combination
nothingFor(5),
rampUsers(50).during(30),
constantUsersPerSec(5).during(60)
```

### 3. **Using Feeders**
```scala
// CSV feeder
val csvFeeder = csv("data/users.csv").circular()

val scenario = scenario("Test")
  .feed(csvFeeder)
  .exec(karateFeature("classpath:test.feature"))

// Custom feeder
val customFeeder = Iterator.continually(Map(
  "userId" -> getNextUserId(),
  "token" -> getNextToken()
).asJava).asJava

val scenario = scenario("Test")
  .feed(customFeeder)
  .exec(karateFeature("classpath:test.feature"))
```

---

## Best Practices

### 1. **Organization**
- ✅ Group related tests in feature files
- ✅ Use `Background` for common setup
- ✅ Create reusable helper features
- ✅ Keep scenarios independent

### 2. **Data Management**
- ✅ Use external data files (JSON, CSV)
- ✅ Generate dynamic data with Java utilities
- ✅ Use `callonce` for expensive operations
- ✅ Clean up test data after execution

### 3. **Assertions**
- ✅ Use schema validation for complex objects
- ✅ Leverage fuzzy matching (`#string`, `#number`, etc.)
- ✅ Assert on specific fields, not entire responses
- ✅ Use `match contains` for partial matching

### 4. **Performance**
- ✅ Run tests in parallel
- ✅ Use `callonce` for shared setup
- ✅ Minimize external calls in loops
- ✅ Configure appropriate timeouts

### 5. **Debugging**
```gherkin
# Print variables
* print 'userId:', userId
* print response

# Pretty print JSON
* print karate.pretty(response)

# Conditional logging
* if (responseStatus != 200) karate.log('ERROR:', response)

# Karate logger
* karate.log('Processing user:', userId)
```

### 6. **Error Handling**
```gherkin
# Optional fields
* def email = karate.get('response.email', 'default@test.com')

# Try-catch pattern
* def result = 
"""
function() {
  try {
    return response.data.user.email;
  } catch(e) {
    return 'unknown@test.com';
  }
}
"""

# Conditional execution
* if (response.status == 'active') karate.call('activate-user.feature', { id: userId })
```

---

## Official Resources

### 📖 Documentation
- **GitHub Repository**: https://github.com/karatelabs/karate
- **Official Documentation**: https://karatelabs.github.io/karate/
- **API Documentation**: https://karatelabs.github.io/karate/karate-core/

### 💡 Learning Resources
- **Examples**: https://github.com/karatelabs/karate/tree/master/karate-demo
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/karate
- **Karate University**: https://www.karatelabs.io/karate-university

### 📹 Videos & Tutorials
- **YouTube**: Search for "Karate DSL tutorials"
- **Karate Labs Channel**: Official tutorials and demos

### 🛠️ Tools & Plugins
- **VS Code Extension**: Karate Runner
- **IntelliJ Plugin**: Karate
- **Maven Plugin**: `karate-maven-plugin`
- **Gradle Plugin**: Available in official repo

### 📚 Books & Courses
- **Udemy**: "Karate DSL: Complete Guide to API Testing"
- **Test Automation University**: Free Karate courses

### 🐛 Support
- **GitHub Issues**: https://github.com/karatelabs/karate/issues
- **Discussions**: https://github.com/karatelabs/karate/discussions
- **Slack Community**: Join via GitHub

### 🔧 Related Projects
- **Karate Labs**: https://www.karatelabs.io/
- **Karate Gatling**: Performance testing integration
- **Karate Robot**: UI automation framework

---

## Quick Reference Card

### Essential Keywords
| Keyword | Purpose | Example |
|---------|---------|---------|
| `url` | Set base URL | `Given url 'https://api.com'` |
| `path` | Set endpoint path | `And path 'users', userId` |
| `method` | HTTP method | `When method GET` |
| `status` | Assert status code | `Then status 200` |
| `request` | Set request body | `And request { name: 'John' }` |
| `response` | Access response | `* def id = response.id` |
| `match` | Assert/validate | `And match response.name == 'John'` |
| `header` | Set header | `Given header Auth = token` |
| `param` | Query parameter | `And param search = 'test'` |
| `def` | Define variable | `* def name = 'John'` |
| `call` | Call feature | `* call read('other.feature')` |
| `read` | Read file | `* def data = read('data.json')` |
| `print` | Debug output | `* print 'Debug:', variable` |

### Fuzzy Matchers
| Matcher | Validates |
|---------|-----------|
| `'#string'` | Any string |
| `'#number'` | Any number |
| `'#boolean'` | Boolean value |
| `'#array'` | Any array |
| `'#object'` | Any object |
| `'#null'` | Null value |
| `'#notnull'` | Not null |
| `'#present'` | Field exists |
| `'#notpresent'` | Field absent |
| `'##string'` | Optional string |
| `'#regex ^[A-Z]'` | Regex pattern |
| `'#[] #string'` | Array of strings |
| `'#[2]'` | Array length 2 |
| `'#? _ > 0'` | Conditional |

---

## Summary

Karate DSL is a powerful, easy-to-learn framework that simplifies API testing while providing advanced features for complex scenarios. Its BDD syntax makes tests readable for non-technical stakeholders, and its rich feature set eliminates the need for multiple tools.

**Key Strengths:**
- 🎯 No programming required for basic tests
- 🚀 Fast execution with parallel support
- 📊 Built-in performance testing
- 🔧 Comprehensive assertion library
- 📝 Excellent documentation and community

**Perfect for:**
- API testing (REST, SOAP, GraphQL)
- Performance/load testing
- Contract testing
- Test automation in CI/CD pipelines
- Teams with mixed technical skills

---

*Last Updated: February 2026*
*For the latest information, always refer to the official documentation.*
