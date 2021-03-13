# Test suite for Conduit app

### Technology stack:
- Karate (for BDD testing)
- Java
- Maven
- Docker
- Gatling (for HTTP interaction)
- Cucumber reporting

### Concepts illustrated in this suite of tests:
- Embedded and multi-line expressions
- Data driven scenarios (Scenario Outline & Examples table)
- Fuzzy matching 
- Assertions for response
- Schema validation using patterns
- Test data generator (dynamic values)
- Read other files
- Before and After hooks 
- Separate runner for parallel execution
- Conditional logic 
- Type conversion   
- Authentication with token
- Cucumber reporting

### 1. Functional tests

#### Run tests that contains specific tag
`mvn test -Dkarate.options="--tags @debug"`

#### Clean the *target* folder before the execution
`mvn clean test`

#### Reporting
Added `Cucumber` reporting dependency in `pom.xml` and a new method `generateReport` in `ParallelRunTest` runner.
The most generous cucumber report is `target/cucumber-html-reports/overview-features.html`

#### Build Docker image 
`docker build -t karatetest .`

#### Run docker container called *karatetest*
`docker run -it karatetest`

#### Run docker compose
`docker-compose up --build`

#### Shut down container
`docker-compose down`

### 2. Performance tests
Performance tests are used to check service behaviour & functionality under high loads of traffic.

Tests are written using *karate* and *gatling*.

#### Execution
To run all conduitApp.performance tests on the local machine, use next command:

`mvn clean test-compile gatling:test`

#### Metrics

`MAX_DURATION` - X minutes (maximum duration of the simulation)

`REQUESTS_SUCCESSFUL_PERCENTAGE` - 99.9 (percentage of successful requests under test)

`INITIAL_LOAD` - X (initial number of requests)

`MAX_LOAD` - X (maximum number of requests)

`RAMP_PERIOD_MINS` - X minutes (ramp up period in minutes)

`SUSTAIN_PERIOD_MINS` - X minute (sustain period in minutes)

#### Performance Tests Reporting

[comment]: <> (#TODO)
By running the tests on the local machine, Gatling reports are generated (project root -> gatlingResults folder -> simulationName -> index.html)

