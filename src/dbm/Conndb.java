package dbm;

import java.sql.*;

import javax.sql.*;
import javax.naming.*;

public class Conndb {
	
	//注意
	public Connection conn;
	private Context initContext;

	public Conndb() {
		conn = null;
		initContext = null;
		DataSource ds = null;
		try {
			initContext = new InitialContext();
			ds = (DataSource) initContext.lookup("java:comp/env/jdbc/weibo");
			conn = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ResultSet execute(String sql) {
		// System.out.println("sql sentences:" + sql);
		// stmt.executeQuery(sql);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return rs;
	}

	public void destory() {
		try {
			conn.close();
			conn = null;
			initContext.close();
			initContext = null;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
