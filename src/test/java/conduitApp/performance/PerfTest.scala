package performance

import com.intuit.karate.gatling.javaapi.KarateProtocolBuilder

import io.gatling.javaapi.core.ScenarioBuilder
import io.gatling.javaapi.core.Simulation

import io.gatling.javaapi.core.CoreDsl._
import com.intuit.karate.gatling.javaapi.KarateDsl._
import conduitApp.performance.createTokens.CreateTokens
import scala.jdk.CollectionConverters._
import java.util.{Map => JMap}

class PerfTest extends Simulation { 
      
      CreateTokens.createAccessTokens()
    val protocol = karateProtocol(
      uri("/cats/{id}").nil(),
      uri("/cats").pauseFor(method("get", 15), method("post", 25)
    ))

    protocol.nameResolver = (req, ctx) -> req.getHeader("karate-name")
    protocol.runner.karateEnv("perf")

    // CSV feeder - provides title and description for each user
    val csvFeeder = csv("conduitApp/performance/data/articles.csv").circular()
    
    // Token feeder - cycles through 3 pre-generated tokens
    val tokenFeeder = Iterator.continually {
      val token: Object = CreateTokens.getNextToken()
      Map[String, Object]("token" -> token).asJava
    }.asJava
    
    // Each user gets: their own token + their own title/description from CSV
    val createArticle = scenario("Create and delete Article").feed(tokenFeeder).feed(csvFeeder).exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))


    // Simple setup: 3 users, each with unique token and article data
    setUp(
      createArticle.injectOpen(atOnceUsers(3)).protocols(protocol)
    )
}