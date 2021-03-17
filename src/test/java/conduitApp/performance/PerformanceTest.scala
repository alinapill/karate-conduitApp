package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder
import conduitApp.performance.createTokens.CreateTokens

class PerformanceTest extends Simulation {

  // The patterns in karateProtocol allow you to aggregate the endpoint results in the Gatling report.
  val protocol = karateProtocol("/api/articles/{articleId}" -> Nil) // in Scala, Nil = Null

  CreateTokens.createAccessTokens()

  val csvFeeder = csv("articles.csv").circular
  val tokenFeeder = Iterator.continually(Map("token" -> (CreateTokens.getNextToken)))

  val nightlyScn: ScenarioBuilder = scenario("Nightly Simulation")
    .feed(csvFeeder)
    .feed(tokenFeeder)
    .randomSwitch(
      35.0 -> exec(karateFeature("classpath:conduitApp/performance/createArticle.feature", "@performance")),
      65.0 -> exec(karateFeature("classpath:conduitApp/performance/getTags.feature", "@performance"))
    )

  setUp(
    nightlyScn.inject(atOnceUsers(2)).protocols(protocol)
  )

}