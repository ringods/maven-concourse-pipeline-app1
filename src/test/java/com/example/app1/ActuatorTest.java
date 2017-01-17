package com.example.app1;

import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import io.restassured.RestAssured;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "classpath:actuator.feature"
)
public class ActuatorTest {

	@BeforeClass
	public static void initRestAssured() {
		RestAssured.baseURI = System.getProperty("baseURI", System.getenv("baseURI"));
		String port = System.getProperty("port", System.getenv("PORT"));
		if (port != null) {
			RestAssured.port = Integer.valueOf(port);
		}
	}
	
}
