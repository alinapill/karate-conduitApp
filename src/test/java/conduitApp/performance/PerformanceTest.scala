package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

class PerformanceTest extends Simulation {

  val protocol = karateProtocol()
  val createArticle = scenario("Get all tags").exec(karateFeature("classpath:conduitApp/performance/getTags.feature", "@performance"))

  setUp(
    createArticle.inject(atOnceUsers(100)).protocols(protocol)
  )

}