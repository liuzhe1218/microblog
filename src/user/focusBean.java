package user;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbm.Conndb;
public class focusBean {
	//实现的功能：判断是否是我的关注好友，未关注：添加关注，并且在index.jsp中添加好友的微博，以关注：解除关注按钮
	PreparedStatement stat;
	ResultSet rs;
	boolean judge ;
	boolean judge1;
	Conndb conndb = new Conndb();
	public void destroy() {
		try {
			stat.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		conndb.destory();
		stat=null;
		conndb=null;
		//super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public focusBean(String auid, String friend){
		String select ="select auid,buid from fol where auid=? and buid=? ";
		try {
			stat= conndb.conn.prepareStatement(select);
			stat.setString(1,auid);
			stat.setString(2,friend);
			rs = stat.executeQuery();
			if (rs.next())
				judge =true;//已加关注，结果集非空
			else 
				judge=false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public boolean getjudge(){
		return judge;//实例化构造函数之后，拿到时候添加过好友的boolean变量
	}
	public void addfocus(String auid ,String friend){
		String add = "insert into fol values (?,?)";
		try {
			stat = conndb.conn.prepareStatement(add);
			stat.setString(1,auid);
			stat.setString(2,friend);
			stat.executeUpdate();//完成插入
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	public void delfocus(String auid ,String friend){
		String del ="delete from fol where auid=? and buid=?";
		try {
			stat=conndb.conn.prepareStatement(del);
			stat.setString(1,auid);
			stat.setString(2,friend);
			stat.executeUpdate();
			//System.out.println(1+auid+"|"+friend);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ResultSet showfocus(String auid){
		String show ="select uid,content,time from mb where uid in(select buid from fol where auid=?)";
		try {
			stat=conndb.conn.prepareStatement(show);
			stat.setString(1,auid);
			rs=stat.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.destroy();
		return rs;
	}
}
