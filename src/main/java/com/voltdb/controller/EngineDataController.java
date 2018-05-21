package com.voltdb.controller;

import org.voltdb.client.*;

import com.voltdb.beans.EngineData;

import java.io.IOException;
import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.voltdb.VoltTable;
import org.voltdb.VoltType;

@Controller
public class EngineDataController {

    @Autowired
    Client client;
	
    @RequestMapping(value = "/select")
    @ResponseBody
	public String selectEngineData(String tableName,String tractorId){
    	
        if((tableName == null || tableName.isEmpty())&&(tractorId == null || tractorId.isEmpty())) {
    	tableName = "tb_engine_data";
         tractorId = "'777'";
         }
        
        try {
			client.callProcedure(new SearchDataCallback(),"@AdHoc", "SELECT * FROM " + tableName+" WHERE tractor_id= "+tractorId);
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "HELLO WORLD!";
    }
    
    @RequestMapping(value = "/insert")
    @ResponseBody
	public String insertEngineData(String tableName,String tractorId){
    	       
        // Get the alerts
        try {
			client.callProcedure(new EngineDataCallback(),
			                         "LoadEngineData",
			                         "862952026635317", "777", 80,100,100,100,80,80,15);
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "HELLO WORLD!";
    }
    
    @RequestMapping(value = "/FindLastEngineData")
    @ResponseBody
	public String findLastEngineData(String tractorId){
    	
        if(tractorId == null || tractorId.isEmpty()) {
         tractorId = "6";
         }
        
        try {
			client.callProcedure(new SearchDataCallback(),"FindLastEngineData",tractorId );
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "HELLO WORLD!";
    }

  
    static class EngineDataCallback implements ProcedureCallback {
        @Override
        public void clientCallback(ClientResponse response) throws Exception {
            if (response.getStatus() == ClientResponse.SUCCESS) {
            	System.out.println("插入数据成功!");
             }else {
            	 System.out.println("插入数据失败!");
             }
        }
    }
    
    static class SearchDataCallback implements ProcedureCallback {
        @Override
        public void clientCallback(ClientResponse response) throws Exception {
        	if (response.getStatus() == ClientResponse.SUCCESS) {
        		System.out.println("查询数据成功!");
        		VoltTable results = response.getResults()[0];
        		
        		//记录当前数据的位置，扫描一次可不用
        		//tuples.resetRowPosition();
        		
        		while (results.advanceRow()) {        		
        		String drcId=results.getString(0);
                String tractorId=results.getString(1);
                int torque=(Integer)results.get(2,VoltType.INTEGER);
                Double rpm=results.getDouble(3);
                Double fuelConsumption=results.getDouble(4);
                int oilPressure=(Integer)results.get(5,VoltType.INTEGER);
                int coolantTemp=(Integer)results.get(6,VoltType.INTEGER);
                Double engineOnlineHour=results.getDouble(7);
                Double pedalPosition=results.getDouble(8);
                Timestamp timeStamp=results.getTimestampAsSqlTimestamp(9);
                EngineData ed = new EngineData(drcId, tractorId, torque, rpm, fuelConsumption, oilPressure, coolantTemp, engineOnlineHour, pedalPosition, timeStamp);
        		System.out.println(ed);
        		}
        		
        		}else {System.out.println("查询数据失败!");}
        	}
    }


}
