package com.example.demo;

import java.sql.Timestamp;

public class Test {
public static void main(String[] args) {
    long between = 0;
    try {
    	Timestamp start =new Timestamp(System.currentTimeMillis());
    	Thread.sleep(500);  
    	Timestamp end =new Timestamp(System.currentTimeMillis());
        between = (end.getTime() - start.getTime());// 得到两者的毫秒数
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    long day = between / (24 * 60 * 60 * 1000);
    long hour = (between / (60 * 60 * 1000) - day * 24);
    long min = ((between / (60 * 1000)) - day * 24 * 60 - hour * 60);
    long s = (between / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
    long ms = (between - day * 24 * 60 * 60 * 1000 - hour * 60 * 60 * 1000
            - min * 60 * 1000 - s * 1000);
    System.out.println(day + "天" + hour + "小时" + min + "分" + s + "秒" + ms
            + "毫秒");
}
}
