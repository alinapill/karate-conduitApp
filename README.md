# Test suite for Conduit app

### Run tests that contains specific tag
`mvn test -Dkarate.options="--tags @debug"`

### Clean the *target* folder before the execution
`mvn clean test`

### Reporting
Added `Cucumber` reporting dependency in `pom.xml` and a new method `generateReport` in `ParallelRunTest` runner.
The most generous cucumber report is `target/cucumber-html-reports/overview-features.html`