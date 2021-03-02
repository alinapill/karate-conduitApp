package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ParallelRunTest {

    @Test
    void testParallel() {
        Results results = Runner.parallel(getClass(),5);
        assertEquals(0, results.getFailCount(), results.getFailCount());
    }

}

