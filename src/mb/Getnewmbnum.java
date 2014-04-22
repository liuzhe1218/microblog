package mb;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbm.Conndb;

public class Getnewmbnum extends HttpServlet {
	public Getnewmbnum() {
		super();
	}
	public void destroy() {
		try {
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		conndb.destory();
		ps=null;
		conndb=null;
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		conndb = new Conndb();
		try {
			ps = conndb.conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession user_session = request.getSession();
		String uid=(String)user_session.getAttribute("uid");
		String lastmbtime=(String)user_session.getAttribute("lastmb");
		String count;
		if(uid==null){
			destroy();
			return;
		}
		rs=null;
		try {
			ps.setString(1, lastmbtime);
			ps.setString(2, uid);
			
			rs=ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
			this.destroy();
			return;
		}
		boolean ok=false;
		try {
			ok=rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
			this.destroy();
			return;
		}
		if(!ok){
			this.destroy();
			return;
		}
		/*
		int count;
		try {
			count = rs.getInt(1);
		*/
		/*
		rs = conndb.execute("select count(*) from mb where time>'2011' and uid in (select buid from fol where auid='2')");
		
		*/
		try {
			
			count = rs.getString(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
			this.destroy();
			return;
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		//System.out.println("count:"+count+"|time|"+lastmbtime+"|"+uid);
  		//System.out.println(request.getParameter("xtamp"));
		out.print(count);
		out.flush();
		out.close();
		this.destroy();
		return;
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
	public void init() throws ServletException {
		// Put your code here
	}
	private Conndb conndb;
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql = "select count(*) from mb where type!='r' and time>? and uid in (select buid from fol where auid=?)";
}
