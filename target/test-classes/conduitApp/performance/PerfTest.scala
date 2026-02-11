package performance

import com.intuit.karate.gatling.javaapi.KarateProtocolBuilder

import io.gatling.javaapi.core.ScenarioBuilder
import io.gatling.javaapi.core.Simulation

import io.gatling.javaapi.core.CoreDsl._
import com.intuit.karate.gatling.javaapi.KarateDsl._

class PerfTest extends Simulation { 
      
    val protocol = karateProtocol(
      uri("/cats/{id}").nil(),
      uri("/cats").pauseFor(method("get", 15), method("post", 25)
    ))

    //protocol.nameResolver = (req, ctx) -> req.getHeader("karate-name")
    protocol.runner.karateEnv("perf")

    val csvFeeder = csv("articles.csv").circular()
    val createArticle = scenario("Create and delete Article").feed(csvFeeder).exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


    setUp(
      createArticle.injectOpen(
        nothingFor(5),                              // Warm-up: 5 seconds
        rampUsers(20).during(60),                   // Gradually ramp up 20 users over 1 minute
        constantUsersPerSec(1).during(30),          // Steady load: 1 user/sec for 30 seconds
        nothingFor(10)                              // Cool-down: 10 seconds
      ).protocols(protocol)
    ).maxDuration(180)                              // Maximum test duration: 3 minutes
}