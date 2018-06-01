package com.voltdb.procedure;
import org.voltdb.*;
import java.sql.Timestamp;

public class LoadEngineData extends VoltProcedure {

  public final SQLStmt InsertEngineData = new SQLStmt(
      " INSERT INTO cache_engine_data VALUES (?,?,?,?,?,?,?,?,?,?);");

  public VoltTable[] run(String drc_id,
                         String tractor_id,
                         int torque,
                         Double rpm,
                         Double fuel_consumption,
                         int oil_pressure,
                         int coolant_temp,
                         Double engine_online_hour,
                         Double pedal_position)
      throws VoltAbortException {

            // Insert a description of the alert
        	  voltQueueSQL( InsertEngineData, 
                		drc_id,
                		tractor_id,
                		torque,
                		rpm,
                		fuel_consumption,
                		oil_pressure,
                		coolant_temp,
                		engine_online_hour,
                		pedal_position,
                		new Timestamp(System.currentTimeMillis()));
          return voltExecuteSQL();
      }

}
