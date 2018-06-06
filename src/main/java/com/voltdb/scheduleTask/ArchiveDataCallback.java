package com.voltdb.scheduleTask;

import org.voltdb.client.ClientResponse;
import org.voltdb.client.ProcedureCallback;

public class ArchiveDataCallback implements ProcedureCallback{
	@Override
    public void clientCallback(ClientResponse response) throws Exception {
        if (response.getStatus() == ClientResponse.SUCCESS) {
        	System.out.println("已将数据传输至JDBC流中!");
         }else {
        	System.out.println("归档数据失败!");
        	System.out.println(response.getStatus());
         }
    }

}
