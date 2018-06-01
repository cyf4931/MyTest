package com.voltdb.procedure;
import org.voltdb.*;
import java.sql.Timestamp;

public class FindLastEngineData extends VoltProcedure {

  public final SQLStmt FindLastTimestamp = new SQLStmt(
      " SELECT MAX(time_stamp) from cache_engine_data WHERE tractor_id=?;");
  
  public final SQLStmt FindLastEngineData = new SQLStmt(
	      " SELECT * from cache_engine_data WHERE time_stamp=?;");
	  

  public VoltTable[] run(String tractor_id) throws VoltAbortException {

            // Insert a description of the alert
        	  voltQueueSQL(FindLastTimestamp,tractor_id);
        	  VoltTable[] results = voltExecuteSQL();
        	  results[0].advanceRow();
        	  Timestamp timeStamp=results[0].getTimestampAsSqlTimestamp(0);
        	  voltQueueSQL(FindLastEngineData,timeStamp);
          return voltExecuteSQL();
      }

}
