package br.com.argeu.helloworld;  

import java.util.concurrent.atomic.AtomicLong;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("hello")
public class HelloWorldController {  
    private static final String template = "Hello, %s!";
	private final AtomicLong counter = new AtomicLong();

	@GetMapping(value = "/{name}", produces = "application/json")
	public HelloWorld hello(@PathVariable String name) {
		return new HelloWorld(counter.incrementAndGet(), String.format(template, name));
	}
}