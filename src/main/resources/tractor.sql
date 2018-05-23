CREATE TABLE tb_engine_data (
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

PARTITION TABLE tb_engine_data ON COLUMN tractor_id;
CREATE INDEX engine_idx ON tb_engine_data (tractor_id, time_stamp);