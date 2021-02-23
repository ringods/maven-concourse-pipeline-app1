package com.example;

import org.springframework.stereotype.Service;

@Service
public class GreetingService {
	private String greeting;

	public GreetingService() {
	}

	public GreetingService(String greeting) {
		super();
		this.greeting = greeting;
	}

	public String welcome(String name) {
		// Adding some docs here.
		return String.format(greeting, name);  
	}
}
