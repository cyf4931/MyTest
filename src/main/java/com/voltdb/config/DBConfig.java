package com.voltdb.config;

import java.io.IOException;
import java.net.UnknownHostException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.voltdb.client.Client;
import org.voltdb.client.ClientFactory;

@Configuration
public class DBConfig {
	@Bean
	public Client getClient() throws UnknownHostException, IOException {
		Client client;
        client = ClientFactory.createClient();
        client.createConnection("10.170.7.22");
        return client;
	}

}
