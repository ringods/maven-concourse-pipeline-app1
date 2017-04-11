package com.example;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class GreetingServiceTest {

	GreetingService service;
	String greeting = "hello %s";
	
	@Before
	public void setup() {
		service = new GreetingService(greeting);
	}
	
	@Test
	public void shallGreetUs() {
		assertEquals(String.format(greeting, "Bob"), service.welcome("Bob"));
	}

}
