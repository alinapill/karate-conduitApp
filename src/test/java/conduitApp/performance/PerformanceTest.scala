package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder
import conduitApp.performance.createTokens.CreateTokens

import scala.concurrent.duration.{DurationInt, SECONDS}

class PerformanceTest extends Simulation {

  // The patterns in karateProtocol allow you to aggregate the endpoint results in the Gatling report.
  val protocol = karateProtocol("/api/articles/{articleId}" -> Nil) // in Scala, Nil = Null

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  CreateTokens.createAccessTokens()

  val csvFeeder = csv("articles.csv").circular
  val tokenFeeder = Iterator.continually(Map("token" -> (CreateTokens.getNextToken)))

  val nightlyScn: ScenarioBuilder = scenario("Performance simulation")
    .feed(csvFeeder)
    .feed(tokenFeeder)
    .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature", "@performance")
    )

  setUp(
    nightlyScn.inject(
      nothingFor(4.seconds),
      atOnceUsers(2),
      rampUsers(5).during(5.seconds),
      constantUsersPerSec(3).during(10.seconds),
      constantUsersPerSec(3).during(10.seconds).randomized,
      rampUsersPerSec(4).to(10).during(10.seconds),
      rampUsersPerSec(4).to(20).during(10.seconds).randomized,
      heavisideUsers(5).during(10.seconds)
    ).protocols(protocol)
  ).maxDuration(5.minute)

}

