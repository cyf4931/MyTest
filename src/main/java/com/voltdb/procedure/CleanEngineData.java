package com.voltdb.procedure;

import java.sql.Timestamp;

import org.voltdb.SQLStmt;
import org.voltdb.VoltProcedure;
import org.voltdb.VoltTable;


public class CleanEngineData extends VoltProcedure{
	public final SQLStmt CleanEngineData = new SQLStmt(
		      " DELETE from cache_engine_data WHERE time_stamp>? AND time_stamp<?;");
	
	public VoltTable[] run(Timestamp start,Timestamp end) throws VoltAbortException {
        // Insert a description of the alert
    	  voltQueueSQL(CleanEngineData,start,end);
      return voltExecuteSQL();
  }
}
