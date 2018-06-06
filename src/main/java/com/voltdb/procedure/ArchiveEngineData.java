package com.voltdb.procedure;

import java.sql.Timestamp;

import org.voltdb.SQLStmt;
import org.voltdb.VoltProcedure;
import org.voltdb.VoltTable;

public class ArchiveEngineData extends VoltProcedure{
	 public final SQLStmt ArchiveEngineData = new SQLStmt(
		      " insert into tb_engine_data select * from cache_engine_data where time_stamp>? and time_stamp<?;");
	 
	 public VoltTable[] run(Timestamp start,Timestamp end) throws VoltAbortException {
         // Insert a description of the alert
     	  voltQueueSQL(ArchiveEngineData,start,end);
       return voltExecuteSQL();
   }
}
