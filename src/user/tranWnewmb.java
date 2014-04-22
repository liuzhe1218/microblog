package user;

import dbm.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class tranWnewmb extends HttpServlet {
	Conndb conndb = new Conndb();
	PreparedStatement stat,stat1 ;
	ResultSet rs;
    int k =0;//测试是否完成转发的标志位 
	public tranWnewmb() {
		super();
	}
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
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return;
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();//返回信息
		response.setContentType("text/html");
		HttpSession user_session = request.getSession();
		String insert = "INSERT INTO mb(type,uid,ouid,ombid,content)VALUES(?,?,?,?,?)";
		String select = "SELECT content FROM mb WHERE uid=? AND mbid=?";
		String name = (String)user_session.getAttribute("uid");//获取登录名
		String information = request.getParameter("id");//根据不同的ID赋值，给后台传过来不同的ouid_ombid_t
		String content = request.getParameter("content");
		String a="_";//id_trans
		int b = information.indexOf(a,0);//preuid_prembid字符串中_所在的位置
		int c = information.lastIndexOf(a);//找到最后一个'_'
        String d = information.substring(0,b);//ouid
        String f = information.substring(b+1,c);//ombid
        String type = information.substring(c+1,information.length());
        //System.out.println("tranWnewmb1:"+information+content);
        //System.out.println("tranWnewmb2:"+d+"|"+f+"|"+type);
        
        try {
			stat=conndb.conn.prepareStatement(select);
			stat.setString(1,d);
			stat.setString(2,f);
			rs=stat.executeQuery();
			if(!rs.next()){
				//response.sendRedirect("transfail.jsp");
				out.print("fail");
				return;
			}
			else{
			stat1=conndb.conn.prepareStatement(insert);
			stat1.setString(1,type);
			stat1.setString(2,name);
			stat1.setString(3,d);
			stat1.setString(4,f);
			stat1.setString(5,htmlspecialchars(content));	
			stat1.executeUpdate();//完成转发文章的功能，即插入该文章到用户mb数据库下，type为't'
			k=1;	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.destroy();
			return;
		}
        if(k==1){			
			out.print("success");//给前台返回转发成功的信息
			
			}
			else if(k==0){
				//response.sendRedirect("transfail.jsp");//转发失败
				out.print("fail");//给前台转发失败的信息
				return;
			}
        out.flush();
	    out.close();              
	}		
	private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll(",", "&#44");
		str = str.replaceAll("'", "&apos;");
		return str;
	}
}
