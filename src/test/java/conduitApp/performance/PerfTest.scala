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

    val createArticle = scenario("Create and delete Article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


    setUp(
      createArticle.injectOpen(atOnceUsers(1)).protocols(protocol)
    )
}