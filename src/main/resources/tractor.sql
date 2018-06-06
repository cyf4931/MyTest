CREATE TABLE cache_engine_data (
  drc_id varchar(25) NOT NULL,
  tractor_id varchar(25) NOT NULL,
  torque INTEGER,
  rpm FLOAT,
  fuel_consumption FLOAT,
  oil_pressure INTEGER ,
  coolant_temp INTEGER ,
  engine_online_hour FLOAT,
  pedal_position FLOAT,
  time_stamp TIMESTAMP NOT NULL,
  PRIMARY KEY (tractor_id,time_stamp)
);

CREATE STREAM tb_engine_data
EXPORT TO TARGET archive PARTITION ON COLUMN tractor_id(  
drc_id varchar(25) NOT NULL,
  tractor_id varchar(25) NOT NULL,
  torque INTEGER,
  rpm FLOAT,
  fuel_consumption FLOAT,
  oil_pressure INTEGER ,
  coolant_temp INTEGER ,
  engine_online_hour FLOAT,
  pedal_position FLOAT,
  time_stamp TIMESTAMP NOT NULL
);

PARTITION TABLE cache_engine_data ON COLUMN tractor_id;
CREATE INDEX engine_idx ON cache_engine_data (time_stamp);

LOAD CLASSES tractor.jar;

CREATE PROCEDURE PARTITION ON TABLE cache_engine_data COLUMN tractor_id FROM CLASS FindLastEngineData;
CREATE PROCEDURE FROM CLASS ArchiveEngineData;
CREATE PROCEDURE FROM CLASS CleanEngineData;