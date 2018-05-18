CREATE TABLE `tb_engine_data` (
  `id` bigint(20) UNIQUE NOT NULL AUTO_INCREMENT ,
  `drc_id` varchar(25) DEFAULT NULL ,
  `tractor_id` varchar(25) DEFAULT NULL ,
  `torque` int(11) DEFAULT NULL ,
  `rpm` double DEFAULT NULL ,
  `fuel_consumption` float DEFAULT NULL ,
  `oil_pressure` int(11) DEFAULT NULL ,
  `coolant_temp` int(11) DEFAULT NULL ,
  `engine_online_hour` double DEFAULT NULL ,
  `pedal_position` float DEFAULT NULL ,
  `time_stamp` datetime DEFAULT NULL ,
  PRIMARY KEY (`id`)
)


CREATE TABLE `tb_gps_data` (
  `id` bigint(20) UNIQUE NOT NULL AUTO_INCREMENT,
  `drc_id` varchar(25) DEFAULT NULL,
  `tractor_id` varchar(25) DEFAULT NULL,
  `version` varchar(25) DEFAULT NULL ,
  `latitude` double DEFAULT NULL,
  `latitude_flag` int(11) DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `longitude_flag` int(11) DEFAULT NULL,
  `altitude` float DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `azimuth` float DEFAULT NULL,
  `total_mileage` varchar(255) DEFAULT NULL,
  `single_mileage` varchar(255) DEFAULT NULL,
  `cellid` varchar(10) DEFAULT NULL,
  `lac` varchar(10) DEFAULT NULL,
  `mcc` varchar(10) DEFAULT NULL,
  `mnc` varchar(10) DEFAULT NULL,
  `power` float DEFAULT NULL,
  `extpower` float DEFAULT NULL,
  `gps_num` varchar(5) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
)

PARTITION TABLE tb_engine_data ON COLUMN drc_id;
PARTITION TABLE tb_gps_data ON COLUMN drc_id;

CREATE INDEX engine_idx ON tb_engine_data (drc_id, time_stamp);
CREATE INDEX gps_idx ON tb_gps_data (drc_id, time_stamp);
