package conduitApp;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;

// un-comment 'KarateOptions' to run only the Features having '@debug'
//@KarateOptions(tags = {"debug"})
class ConduitTest {
    
    // this will run all *.feature files that exist in sub-directories
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}

