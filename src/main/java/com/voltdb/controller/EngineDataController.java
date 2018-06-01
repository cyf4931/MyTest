package com.voltdb.controller;

import org.voltdb.client.*;

import com.voltdb.beans.EngineData;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Random;

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
    
    public static int count=0;
    public static Timestamp start =new Timestamp(System.currentTimeMillis());
    public static Timestamp end =new Timestamp(System.currentTimeMillis());
    
	
    @RequestMapping(value = "/select")
    @ResponseBody
	public String selectEngineData(String tableName,String tractorId){
    	
        if((tableName == null || tableName.isEmpty())&&(tractorId == null || tractorId.isEmpty())) {
    	tableName = "cache_engine_data";
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
    
    @RequestMapping(value = "/selectAll")
    @ResponseBody
	public String selectAllEngineData(){
        try {
			client.callProcedure(new SearchDataCallback(),"@AdHoc", "select * from cache_engine_data where tractor_id='100'");
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
	public String insertEngineData(){
    	       
        // Get the alerts
        try {
			client.callProcedure(new InsertDataCallback(),
			                         "TB_ENGINE_DATA.insert",
			                         "862952026635317", "777", 80,100,100,100,80,80,15,new Timestamp(System.currentTimeMillis()));
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "HELLO WORLD!";
    }
    
    @RequestMapping(value = "/jdbcTest")
    @ResponseBody
	public String insertTest() throws ProcCallException{
    	for(int i=1;i<=1000000;i++) {
    	// Get the alerts
        try {
        	client.callProcedure(new EngineDataCallback(),"TB_ENGINE_DATA.insert","862952026635317",String.valueOf(i),80,100,100,100,80,80,15,new Timestamp(System.currentTimeMillis()));
        	//client.callProcedure(new EngineDataCallback(),"TEST.insert",i, i);
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	}
        return "HELLO WORLD!";
    }
    
    @RequestMapping(value = "/insertTest")
    @ResponseBody
	public String insertTest2() throws ProcCallException{
    	for(int i=1;i<=1000000;i++) {
    	// Get the alerts
        try {
        	client.callProcedure(new EngineDataCallback(),"CACHE_ENGINE_DATA.insert","862952026635317",String.valueOf(i),80,100,100,100,80,80,15,new Timestamp(System.currentTimeMillis()));
        	//client.callProcedure(new EngineDataCallback(),"TEST.insert",i, i);
		} catch (NoConnectionsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	}
        return "HELLO WORLD!";
    }
    
    @RequestMapping(value = "/findLastEngineData")
    @ResponseBody
	public String FindLastEngineData(String tractorId){
    	
        if(tractorId == null || tractorId.isEmpty()) {
         tractorId = "777";
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
        		count++;
            	if(count==1) {    	
            		start =new Timestamp(System.currentTimeMillis());
                	}
            	if(count==999999) {    	
            		end =new Timestamp(System.currentTimeMillis());
            		timing(start,end);
                	}            	
             }else {
            	 System.out.println(response.getStatus());
            	 System.out.println("插入数据失败!");
             }
        }
    }
    
    static class InsertDataCallback implements ProcedureCallback {
        @Override
        public void clientCallback(ClientResponse response) throws Exception {
            if (response.getStatus() == ClientResponse.SUCCESS) {
            	System.out.println("插入数据成功!");
             }else {
            	 System.out.println("插入数据失败!");
            	 System.out.println(response.getStatus());
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
    
    public static void timing(Timestamp start,Timestamp end) {
        long between = 0;
        try {
            between = (end.getTime() - start.getTime());// 得到两者的毫秒数
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        long day = between / (24 * 60 * 60 * 1000);
        long hour = (between / (60 * 60 * 1000) - day * 24);
        long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
        long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
        long ms = (between - day * 24 * 60 * 60 * 1000 - hour * 60 * 60 * 1000
                - min * 60 * 1000 - s * 1000);
        System.out.println(day + "天" + hour + "小时" + min + "分" + s + "秒" + ms
                + "毫秒");
    }


}
