package com.voltdb.scheduleTask;

import org.voltdb.client.ClientResponse;
import org.voltdb.client.ProcedureCallback;

public class CleanDataCallback implements ProcedureCallback{
	@Override
    public void clientCallback(ClientResponse response) throws Exception {
        if (response.getStatus() == ClientResponse.SUCCESS) {
        	System.out.println("已将指定数据清除!");
         }else {
        	System.out.println("删除数据失败!");
        	System.out.println(response.getStatus());
         }
    }

}
