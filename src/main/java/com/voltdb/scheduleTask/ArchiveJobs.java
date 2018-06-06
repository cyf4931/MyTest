package com.voltdb.scheduleTask;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
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
    public void cleanJob() throws SQLException{
        System.out.println("任务启动");
        
        Calendar calendar = Calendar.getInstance();    
        //定制当天凌晨两点时间  
        calendar.set(Calendar.HOUR_OF_DAY, 2);  
        calendar.set(Calendar.MINUTE, 0);  
        calendar.set(Calendar.SECOND, 0);
        
        Date endDate=this.addDay(calendar.getTime(),-7); //数据库同步数据的end时间
        Date startDate=this.addDay(endDate,-1); //数据库同步数据的start时间
        
        //转换时间格式
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String start = formatter.format(startDate);
        String end = formatter.format(endDate);
        
        //输出清理数据的时间段
        System.out.println("start: "+start+" end: "+end);
        
        
        //查询待删除数据是否已归档，若已归档则直接删除，若未归档则在归档后删除
        int count=1;
        System.out.println(count);
        if(isArchived(start,end)) {
        	//直接执行数据清理
        	archiveService.cleanData(start,end);
        }else {
        	//执行归档后进行数据清理
        	archiveService.archiveData(start,end);
            archiveService.cleanData(start,end);
        }     
    }
	
	// 增加或减少天数
	public Date addDay(Date date, int num) {  
        Calendar startDT = Calendar.getInstance();  
        startDT.setTime(date);  
        startDT.add(Calendar.DAY_OF_MONTH, num);  
        return startDT.getTime();  
       }
	
	public boolean isArchived(String start,String end) throws SQLException {
		Connection conn = null;
		int count=1;
        String sql;
        String url = "jdbc:mysql://10.170.7.73:3306/tractordb_archive?"
                + "user=root&password=root&useUnicode=true&characterEncoding=UTF8";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");// 动态加载mysql驱动
            System.out.println("成功加载MySQL驱动程序");
            // 一个Connection代表一个数据库连接
            conn = DriverManager.getConnection(url);
            sql = "select count(*) from tb_engine_data where time_stamp> ? and time_stamp< ? ";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,start);  
            ps.setString(2,end);
            ResultSet rs = ps.executeQuery() ;// 执行查询语句 
            if(rs.next()){ // 如果有数据，则可以执行  
                count = rs.getInt(1);
                System.out.println("count="+count);    
            }     
                       
        } catch (SQLException e) {
            System.out.println("MySQL操作错误");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
        if(count==0) {
            return false;
            }
            else {
            	return true;
            }	
	}
}
