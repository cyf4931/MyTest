package com.voltdb.beans;

import java.sql.Timestamp;

public class EngineData {
	private String drcId;
	private String tractorId;
	private int torque;
	private Double rpm;
	private Double fuelConsumption;
	private int oilPressure;
	private int coolantTemp;
	private Double engineOnlineHour;
	private Double pedalPosition;
	private Timestamp timeStamp;
	
	
	public EngineData(String drcId, String tractorId, int torque, Double rpm, Double fuelConsumption, int oilPressure,
			int coolantTemp, Double engineOnlineHour, Double pedalPosition, Timestamp timeStamp) {
		super();
		this.drcId = drcId;
		this.tractorId = tractorId;
		this.torque = torque;
		this.rpm = rpm;
		this.fuelConsumption = fuelConsumption;
		this.oilPressure = oilPressure;
		this.coolantTemp = coolantTemp;
		this.engineOnlineHour = engineOnlineHour;
		this.pedalPosition = pedalPosition;
		this.timeStamp = timeStamp;
	}
	public String getDrcId() {
		return drcId;
	}
	public void setDrcId(String drcId) {
		this.drcId = drcId;
	}
	public String getTractorId() {
		return tractorId;
	}
	public void setTractorId(String tractorId) {
		this.tractorId = tractorId;
	}
	public int getTorque() {
		return torque;
	}
	public void setTorque(int torque) {
		this.torque = torque;
	}
	public Double getRpm() {
		return rpm;
	}
	public void setRpm(Double rpm) {
		this.rpm = rpm;
	}
	public Double getFuelConsumption() {
		return fuelConsumption;
	}
	public void setFuelConsumption(Double fuelConsumption) {
		this.fuelConsumption = fuelConsumption;
	}
	public int getOilPressure() {
		return oilPressure;
	}
	public void setOilPressure(int oilPressure) {
		this.oilPressure = oilPressure;
	}
	public int getCoolantTemp() {
		return coolantTemp;
	}
	public void setCoolantTemp(int coolantTemp) {
		this.coolantTemp = coolantTemp;
	}
	public Double getEngineOnlineHour() {
		return engineOnlineHour;
	}
	public void setEngineOnlineHour(Double engineOnlineHour) {
		this.engineOnlineHour = engineOnlineHour;
	}
	public Double getPedalPosition() {
		return pedalPosition;
	}
	public void setPedalPosition(Double pedalPosition) {
		this.pedalPosition = pedalPosition;
	}
	public Timestamp getTimeStamp() {
		return timeStamp;
	}
	public void setTimeStamp(Timestamp timeStamp) {
		this.timeStamp = timeStamp;
	}
	@Override
	public String toString() {
		return "EngineData [drcId=" + drcId + ", tractorId=" + tractorId + ", torque=" + torque + ", rpm=" + rpm
				+ ", fuelConsumption=" + fuelConsumption + ", oilPressure=" + oilPressure + ", coolantTemp="
				+ coolantTemp + ", engineOnlineHour=" + engineOnlineHour + ", pedalPosition=" + pedalPosition
				+ ", timeStamp=" + timeStamp + "]";
	}
	
	
}
