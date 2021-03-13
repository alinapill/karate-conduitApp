package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

class PerformanceTest extends Simulation {

  // The patterns in karateProtocol allow you to aggregate the endpoint results in the Gatling report.
  // in Scala, Nil = Null
  val protocol = karateProtocol("/api/articles/{articleId}" -> Nil)

  val nightlyScn: ScenarioBuilder = scenario("Nightly Simulation")
    .randomSwitch(
      35.0 -> exec(karateFeature("classpath:conduitApp/performance/createArticle.feature", "@performance")),
      35.0 -> exec(karateFeature("classpath:conduitApp/performance/createArticle.feature", "@performance")),
      30.0 -> exec(karateFeature("classpath:conduitApp/performance/getTags.feature", "@performance"))
    )

  setUp(
    nightlyScn.inject(atOnceUsers(10)).protocols(protocol)
  )



}