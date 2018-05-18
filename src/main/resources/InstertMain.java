import org.voltdb.*;
import org.voltdb.client.*;
import java.util.Date;

public class InstertMain {

    public static void main(String[] args) throws Exception {

        org.voltdb.client.Client client;
        client = ClientFactory.createClient();
        client.createConnection("localhost");
         
              // Get the alerts
            client.callProcedure(new EngineDataCallback(),
                                 "LoadEngineData",
                                 3,"862952026635317", "88888", 80,100,100,100,80,80,15);
            client.close();
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


}
