package conduitApp.performance.createTokens;

import com.intuit.karate.Runner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateTokens {

    private static final ArrayList<String> tokens = new ArrayList<>();

    private static final AtomicInteger counter = new AtomicInteger();


    private static String[] emails = {
            "conduitdemo1@test.com",
            "conduitdemo2@test.com",
            "conduitdemo3@test.com"
    };

    // read the tokens
    public static String getNextToken() {
      return tokens.get(counter.getAndIncrement() % tokens.size());
    }

public static void createAccessTokens() {
    // iterate through all the list of credentials
    // this iterator will be added into the `account` Map of String and Object type (this is the type that is accepted by the feature file
    // we get the result back and the `authToken` and save it into the `tokens` array

    for(String email: emails) {
        Map<String, Object> account = new HashMap<>();
        account.put("userEmail", email);
        account.put("userPassword", "Welcome1");

        Map<String, Object> result = Runner.runFeature("classpath:helpers/CreateToken.feature", account,true);
        tokens.add(result.get("authToken").toString());
    }
}
}
