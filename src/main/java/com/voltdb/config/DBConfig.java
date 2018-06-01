package com.voltdb.config;

import java.io.IOException;
import java.net.UnknownHostException;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.voltdb.client.Client;
import org.voltdb.client.ClientConfig;
import org.voltdb.client.ClientFactory;

@Configuration
public class DBConfig {
	@Bean
	public Client getClient() throws UnknownHostException, IOException {
		Client client;
		ClientConfig config = new ClientConfig("admin","123456");
		//自动连接集群中所有节点
		config.setTopologyChangeAware(true);
		client = ClientFactory.createClient(config);
        client.createConnection("10.170.7.21");
        return client;
	}

}
