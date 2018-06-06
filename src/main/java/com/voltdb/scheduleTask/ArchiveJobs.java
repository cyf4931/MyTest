package com.voltdb.scheduleTask;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.voltdb.service.ArchiveService;

@Component
public class ArchiveJobs {

    @Autowired
    ArchiveService archiveService;
	
	//每天凌晨两点执行数据规定任务
    @Scheduled(cron="0 0 2 * * ?")
    public void archiveJob(){
        System.out.println("任务启动");
        Calendar calendar = Calendar.getInstance();    
        //定制当天凌晨两点时间  
        calendar.set(Calendar.HOUR_OF_DAY, 2);  
        calendar.set(Calendar.MINUTE, 0);  
        calendar.set(Calendar.SECOND, 0);
        
        Date endDate=calendar.getTime(); //数据库同步数据的end时间
        Date startDate=this.addDay(endDate,-1); //数据库同步数据的start时间
        
        //转换时间格式
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String start = formatter.format(startDate);
        String end = formatter.format(endDate);
        
        //输出归档数据的时间段
        System.out.println("start: "+start+" end: "+end);
        
        //执行数据归档
        archiveService.archiveData(start,end);
    }
	
    //每天凌晨三点执行数据清理任务
	@Scheduled(cron="0 0 3 * * ?")
    public void cleanJob(){
        System.out.println("任务启动");
        archiveService.cleanData();
    }
	
	// 增加或减少天数
	public Date addDay(Date date, int num) {  
        Calendar startDT = Calendar.getInstance();  
        startDT.setTime(date);  
        startDT.add(Calendar.DAY_OF_MONTH, num);  
        return startDT.getTime();  
       }  
	
}
