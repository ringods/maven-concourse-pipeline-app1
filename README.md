# Acceptance Testing of the application using Cucumber

## Introduction

TODO Explain why we have decided to manage the acceptance tests outside the application's source code


## How to run it locally

First, launch our spring boot app `maven-concourse-pipeline-app1 $ mvn spring-boot:run`. It is listening in localhost:8080

Second, run our test `maven-concourse-pipeline-app1-test$ mvn test -DRestAssured.baseURI="http://localhost" -DRestAssured.port=8080" `
```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running com.example.app1.ActuatorTest

1 Scenarios (1 passed)
2 Steps (2 passed)
0m1.309s

Tests run: 3, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 1.639 sec

Results :

Tests run: 3, Failures: 0, Errors: 0, Skipped: 0
```

Third, if we stopped the spring boot app, our test case fails.

The important thing we need to know is how we configure with the location of the application to test.
