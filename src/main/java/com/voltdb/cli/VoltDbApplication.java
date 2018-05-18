package com.voltdb.cli;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.voltdb.config.Config;

@SpringBootApplication
public class VoltDbApplication {

	public static void main(String[] args) {
		SpringApplication.run(Config.class, args);
	}
}
