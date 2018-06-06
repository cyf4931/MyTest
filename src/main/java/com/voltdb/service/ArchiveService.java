package com.voltdb.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.voltdb.client.Client;
import org.voltdb.client.NoConnectionsException;

import com.voltdb.scheduleTask.ArchiveDataCallback;

@Service
public class ArchiveService {
	
    @Autowired
    Client client;
	
	public void archiveData(String start,String end) {
		System.out.println("开始归档当日历史数据");
		
		try {
			client.callProcedure(new ArchiveDataCallback(),"ArchiveEngineData",start,end);
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void cleanData() {
		System.out.println("开始清理七天前数据");
	}

}
