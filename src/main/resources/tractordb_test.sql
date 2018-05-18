/*
Navicat MariaDB Data Transfer

Source Server         : test
Source Server Version : 100034
Source Host           : 10.170.7.73:3306
Source Database       : tractordb_test

Target Server Type    : MariaDB
Target Server Version : 100034
File Encoding         : 65001

Date: 2018-05-11 16:03:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bisiba_tbl_ipfilter
-- ----------------------------
DROP TABLE IF EXISTS `bisiba_tbl_ipfilter`;
CREATE TABLE `bisiba_tbl_ipfilter` (
  `ip` varchar(20) NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_alarm_manager
-- ----------------------------
DROP TABLE IF EXISTS `tb_alarm_manager`;
CREATE TABLE `tb_alarm_manager` (
  `alarm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `alarm_code` int(11) DEFAULT NULL COMMENT '报警数据在通讯协议中对应的标识位',
  `error_name` varchar(25) DEFAULT NULL COMMENT '故障名',
  `state` int(11) DEFAULT NULL COMMENT '是否接受报警状态（0为不接收该报警，1为接收该报警）',
  PRIMARY KEY (`alarm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_authority
-- ----------------------------
DROP TABLE IF EXISTS `tb_authority`;
CREATE TABLE `tb_authority` (
  `authority_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `module_id` int(11) DEFAULT NULL COMMENT '权限模块编号',
  `operation_code` int(11) DEFAULT NULL COMMENT '权限操作码（0为查看操作，1为编辑操作，2为增加操作，3为删除操作）',
  `uri` varchar(255) DEFAULT NULL COMMENT '权限具体URI',
  PRIMARY KEY (`authority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_brand
-- ----------------------------
DROP TABLE IF EXISTS `tb_brand`;
CREATE TABLE `tb_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌编号',
  `brand_name` varchar(25) NOT NULL COMMENT '品牌名称',
  `maker_id` int(11) DEFAULT NULL COMMENT '品牌所属厂商编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_dealer
-- ----------------------------
DROP TABLE IF EXISTS `tb_dealer`;
CREATE TABLE `tb_dealer` (
  `dealer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '经销商编号',
  `dealer_name` varchar(25) DEFAULT NULL COMMENT '经销商名称',
  `contacts_name` varchar(20) DEFAULT NULL COMMENT '联系人姓名',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系人手机号',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`dealer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=462 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_dealer_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `tb_dealer_vehicle`;
CREATE TABLE `tb_dealer_vehicle` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `dealer_id` int(11) DEFAULT NULL COMMENT '经销商编号',
  `tractor_id` bigint(20) DEFAULT NULL COMMENT '拖拉机编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_drc
-- ----------------------------
DROP TABLE IF EXISTS `tb_drc`;
CREATE TABLE `tb_drc` (
  `drc_id` varchar(25) NOT NULL COMMENT 'DRC终端编号',
  `imsi` varchar(25) DEFAULT NULL COMMENT 'DRC终端的imsi号码',
  `version` varchar(10) DEFAULT NULL COMMENT 'DRC终端版本',
  `drc_maker_id` int(11) DEFAULT NULL COMMENT 'DRC制造商编号',
  `production_time` datetime DEFAULT NULL COMMENT '出厂时间',
  `storage_time` datetime DEFAULT NULL COMMENT '入库时间',
  `startup_time` datetime DEFAULT NULL COMMENT '启用时间',
  `state` int(11) DEFAULT NULL COMMENT '状态(0：正常，1：异常，2：禁用)',
  `bind_state` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT 'DRC终端与车辆绑定与否标志位（0：未绑定，1：已绑定）',
  PRIMARY KEY (`drc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_drc_error_num
-- ----------------------------
DROP TABLE IF EXISTS `tb_drc_error_num`;
CREATE TABLE `tb_drc_error_num` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `drc_id` varchar(255) DEFAULT NULL COMMENT 'DRC终端编号',
  `tractor_id` varchar(255) DEFAULT NULL COMMENT '拖拉机ID号',
  `power_alarm` int(11) DEFAULT NULL COMMENT '断电报警',
  `can_alarm` int(11) DEFAULT NULL COMMENT 'CAN总线报警',
  `gps_alarm` int(11) DEFAULT NULL COMMENT 'GPS无信号报警',
  `alarm_rate_number` int(11) DEFAULT NULL COMMENT '报警率',
  `reporting_time` datetime DEFAULT NULL COMMENT '上报时间',
  `time_stamp` datetime DEFAULT NULL COMMENT '服务器接收时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_drc_imsi
-- ----------------------------
DROP TABLE IF EXISTS `tb_drc_imsi`;
CREATE TABLE `tb_drc_imsi` (
  `id` varchar(25) NOT NULL COMMENT 'DRC终端编号',
  `imsi` varchar(25) DEFAULT NULL COMMENT 'imsi号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_drc_maker
-- ----------------------------
DROP TABLE IF EXISTS `tb_drc_maker`;
CREATE TABLE `tb_drc_maker` (
  `drc_maker_id` int(11) NOT NULL COMMENT 'DRC制造商编号',
  `drc_maker_name` varchar(25) DEFAULT NULL COMMENT 'DRC制造商名称',
  `contacts_name` varchar(20) DEFAULT NULL COMMENT '联系人姓名',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系人手机号',
  `adress` varchar(255) DEFAULT NULL COMMENT '详细地址',
  `province` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`drc_maker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_engine_data
-- ----------------------------
DROP TABLE IF EXISTS `tb_engine_data`;
CREATE TABLE `tb_engine_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `drc_id` varchar(25) DEFAULT NULL COMMENT 'DRC终端编号',
  `tractor_id` varchar(25) DEFAULT NULL COMMENT '拖拉机ID号',
  `torque` int(11) DEFAULT NULL COMMENT '扭矩百分比',
  `rpm` double DEFAULT NULL COMMENT '转速',
  `fuel_consumption` float DEFAULT NULL COMMENT '燃油率',
  `oil_pressure` int(11) DEFAULT NULL COMMENT '机油压力',
  `coolant_temp` int(11) DEFAULT NULL COMMENT '冷却液温度',
  `engine_online_hour` double DEFAULT NULL COMMENT '发动机运行时间',
  `pedal_position` float DEFAULT NULL COMMENT '踏板1位置',
  `time_stamp` datetime DEFAULT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_engine_error_num
-- ----------------------------
DROP TABLE IF EXISTS `tb_engine_error_num`;
CREATE TABLE `tb_engine_error_num` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `drc_id` varchar(25) DEFAULT NULL COMMENT 'DRC终端编号',
  `tractor_id` varchar(25) DEFAULT NULL COMMENT '拖拉机ID号',
  `error_num` text COMMENT '故障代码',
  `error_rate_number` int(11) DEFAULT NULL COMMENT '故障率',
  `reporting_time` datetime DEFAULT NULL COMMENT '上报时间',
  `time_stamp` datetime DEFAULT NULL COMMENT '服务器接收时间戳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_fence_polygon
-- ----------------------------
DROP TABLE IF EXISTS `tb_fence_polygon`;
CREATE TABLE `tb_fence_polygon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tractor_id` varchar(25) DEFAULT NULL COMMENT '拖拉机编号',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间戳',
  `state` int(11) DEFAULT NULL COMMENT '暂无用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_gps_data
-- ----------------------------
DROP TABLE IF EXISTS `tb_gps_data`;
CREATE TABLE `tb_gps_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `drc_id` varchar(25) DEFAULT NULL COMMENT 'DRC编号',
  `tractor_id` varchar(25) DEFAULT NULL COMMENT '拖拉机编号',
  `version` varchar(25) DEFAULT NULL COMMENT '协议版本号',
  `latitude` double DEFAULT NULL COMMENT '纬度',
  `latitude_flag` int(11) DEFAULT NULL COMMENT '南纬北纬标志位',
  `longitude` double DEFAULT NULL COMMENT '经度',
  `longitude_flag` int(11) DEFAULT NULL COMMENT '东经西经标志位',
  `altitude` float DEFAULT NULL COMMENT '海拔',
  `speed` float DEFAULT NULL COMMENT '速度',
  `azimuth` float DEFAULT NULL COMMENT '方位角',
  `total_mileage` varchar(255) DEFAULT NULL COMMENT '总行驶里程',
  `single_mileage` varchar(255) DEFAULT NULL COMMENT '本次行驶里程',
  `cellid` varchar(10) DEFAULT NULL COMMENT '小区ID，通过AT+CREG指令获取',
  `lac` varchar(10) DEFAULT NULL COMMENT '位置区编号，通过AT+CREG指令获取',
  `mcc` varchar(10) DEFAULT NULL COMMENT '移动国家码，IMSI中的前3位，通过AT+CIMI指令获取',
  `mnc` varchar(10) DEFAULT NULL COMMENT '移动网络码，IMSI中的第4、5位，通过AT+CIMI指令获取',
  `power` float DEFAULT NULL COMMENT '电池电量',
  `extpower` float DEFAULT NULL COMMENT '外电电量',
  `gps_num` varchar(5) DEFAULT NULL COMMENT 'gps数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间戳（服务器时间）',
  `send_time` datetime DEFAULT NULL COMMENT '发送时间戳（数据包发送时间）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_last_gps_data
-- ----------------------------
DROP TABLE IF EXISTS `tb_last_gps_data`;
CREATE TABLE `tb_last_gps_data` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `drc_id` varchar(255) DEFAULT '' COMMENT 'DRC编号',
  `tractor_id` varchar(255) DEFAULT NULL COMMENT '拖拉机编号',
  `latitude` double(20,10) DEFAULT NULL COMMENT '纬度',
  `longitude` double(20,10) DEFAULT NULL COMMENT '经度',
  `send_time` datetime(6) DEFAULT NULL COMMENT '发送时间戳（数据包发送时间）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_logistic
-- ----------------------------
DROP TABLE IF EXISTS `tb_logistic`;
CREATE TABLE `tb_logistic` (
  `logistic_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '物流编号',
  `arrive_time` datetime DEFAULT NULL COMMENT '到达时间',
  `brand_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `vehicle_license_plate` varchar(255) DEFAULT NULL COMMENT '车牌号',
  `driver_name` varchar(255) DEFAULT NULL COMMENT '司机姓名',
  `driver_phone` varchar(255) DEFAULT NULL COMMENT '司机号码',
  PRIMARY KEY (`logistic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_maker
-- ----------------------------
DROP TABLE IF EXISTS `tb_maker`;
CREATE TABLE `tb_maker` (
  `maker_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '厂商编号',
  `maker_name` varchar(25) DEFAULT NULL COMMENT '厂商名称',
  `contacts_name` varchar(20) DEFAULT NULL COMMENT '联系人姓名',
  `contacts_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT '' COMMENT '城市',
  `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`maker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4655 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_maker_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `tb_maker_vehicle`;
CREATE TABLE `tb_maker_vehicle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `maker_id` int(11) DEFAULT NULL COMMENT '厂商编号',
  `tractor_id` bigint(20) DEFAULT NULL COMMENT '拖拉机编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_module
-- ----------------------------
DROP TABLE IF EXISTS `tb_module`;
CREATE TABLE `tb_module` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限模块编号',
  `module_name` varchar(25) DEFAULT NULL COMMENT '权限模块名称',
  `description` varchar(255) DEFAULT NULL COMMENT '权限模块描述',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_operating_rate
-- ----------------------------
DROP TABLE IF EXISTS `tb_operating_rate`;
CREATE TABLE `tb_operating_rate` (
  `operating_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '开工率编号',
  `operating_rate_number` int(11) DEFAULT NULL COMMENT '开工率',
  `reporting_time` datetime DEFAULT NULL COMMENT '上报时间',
  PRIMARY KEY (`operating_rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(25) DEFAULT NULL COMMENT '角色名称',
  `type` int(11) DEFAULT NULL COMMENT '角色类型',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_role_authority
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_authority`;
CREATE TABLE `tb_role_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色权限关联关系编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `authority_id` int(11) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_stock
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock`;
CREATE TABLE `tb_stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库存编号',
  `tractor_id` varchar(255) DEFAULT NULL COMMENT '拖拉机ID号',
  `vehicle_type_name` varchar(255) DEFAULT NULL COMMENT '拖拉机类型名称',
  `vehicle_model` varchar(255) DEFAULT NULL COMMENT '拖拉机型号',
  `aging` int(255) DEFAULT NULL COMMENT '账龄',
  `maker_id` int(11) DEFAULT NULL COMMENT '厂商编号',
  `dealer_id` int(11) DEFAULT NULL COMMENT '经销商编号',
  `stock_capacity` int(11) DEFAULT NULL COMMENT '库存容量',
  `stock_empty` int(11) DEFAULT NULL COMMENT '库存剩余',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_time_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_time_log`;
CREATE TABLE `tb_time_log` (
  `tractor_id` varchar(25) NOT NULL COMMENT '拖拉机编号',
  `drc_send_time` datetime DEFAULT NULL COMMENT 'DRC定位数据最新上报时间',
  `engine_time_stamp` datetime DEFAULT NULL COMMENT '发动机数据最新上报时间',
  `gps_time_stamp` datetime DEFAULT NULL COMMENT 'GPS模块故障数据最新上报时间',
  PRIMARY KEY (`tractor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `password` varchar(100) DEFAULT NULL COMMENT '用户密码',
  `user_name` varchar(25) DEFAULT NULL COMMENT '用户名',
  `real_name` varchar(10) DEFAULT NULL COMMENT '真实姓名',
  `sex` int(11) DEFAULT NULL COMMENT '性别',
  `email` varchar(30) DEFAULT NULL COMMENT '联系邮箱',
  `type` int(11) DEFAULT NULL COMMENT '类型（0代表车辆用户，1代表厂商用户，2代表经销商用户）',
  `company_id` int(11) DEFAULT NULL COMMENT '用户工作单位编号（厂商编号或经销商编号，车辆用户则为0）',
  `role_id` int(11) DEFAULT NULL COMMENT '用户角色编号',
  `audit_state` int(11) DEFAULT NULL COMMENT '审核状态（0：审核通过，1：审核未通过，2：待审核）',
  `note` varchar(255) DEFAULT '' COMMENT 'app端用户备忘录内容',
  `bind_state` int(11) DEFAULT NULL COMMENT '用户车辆绑定状况（0：未绑定，1：已绑定，2：经销商h和厂商用户无需绑定）',
  `register_time` datetime DEFAULT NULL,
  `image` varchar(512) DEFAULT NULL COMMENT '用户头像图片',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_advice
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_advice`;
CREATE TABLE `tb_user_advice` (
  `advice_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '意见反馈编号',
  `value` varchar(255) DEFAULT NULL COMMENT '匿名意见反馈内容',
  PRIMARY KEY (`advice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_alarm
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_alarm`;
CREATE TABLE `tb_user_alarm` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '接收该报警的用户id',
  `alarm_id` int(11) NOT NULL COMMENT '需要接收报警数据的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '用户角色关联关系编号',
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_vehicle`;
CREATE TABLE `tb_user_vehicle` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '车主用户编号',
  `tractor_id` bigint(20) DEFAULT NULL COMMENT '拖拉机编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `tb_vehicle`;
CREATE TABLE `tb_vehicle` (
  `tractor_id` varchar(20) NOT NULL COMMENT '拖拉机ID号',
  `vehicle_license_plate` varchar(25) DEFAULT NULL COMMENT '拖拉机车牌号',
  `drc_id` varchar(25) DEFAULT NULL COMMENT 'DRC终端编号',
  `vehicle_type` varchar(25) DEFAULT NULL COMMENT '农机类型',
  `brand_name` varchar(25) DEFAULT '' COMMENT '农机品牌名称',
  `flag` int(11) DEFAULT '0' COMMENT '车辆状态（绑定，未绑定，开机限速等……）',
  `ebalarm` int(11) DEFAULT '0' COMMENT '外电警告',
  `zalarm` int(11) DEFAULT '0' COMMENT '工作状态警报（非法振动，超出范围，超出范围非法振动，正常）',
  `production_time` datetime(6) DEFAULT CURRENT_TIMESTAMP(6) COMMENT '出厂时间戳（入库时间戳）',
  `version` varchar(10) DEFAULT '1.1.0' COMMENT '版本号',
  `is_abroad` int(11) DEFAULT '0' COMMENT '区分是国内还是海外(0:国内，1：海外)',
  `service_code` varchar(25) DEFAULT NULL COMMENT '服务编码',
  `maker_id` int(11) DEFAULT NULL COMMENT '厂商编号',
  `dealer_id` int(11) DEFAULT NULL COMMENT '经销商编号',
  `user_id` bigint(11) DEFAULT NULL COMMENT '车主编号',
  `state` int(11) DEFAULT NULL COMMENT '车辆状态（0：正常，1：故障）',
  PRIMARY KEY (`tractor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_vehicle_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_vehicle_type`;
CREATE TABLE `tb_vehicle_type` (
  `id` int(11) NOT NULL COMMENT '车辆类型ID',
  `vehicle_type_name` varchar(25) NOT NULL COMMENT '车辆类型名称',
  `maker_id` int(11) DEFAULT NULL COMMENT '类型所属厂商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
