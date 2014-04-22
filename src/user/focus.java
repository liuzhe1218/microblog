package user;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import dbm.Conndb;

public class focus {
	private static final long serialVersionUID = 1L;
	Conndb fo = new Conndb();
	PreparedStatement stat;
	ResultSet rs ;
	String focuser;
	static String name;
	int k=0;
	public focus() {
		super();
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession focusSession = request.getSession();
		String focuser = request.getParameter("buid");
	    name = (String)focusSession.getAttribute("uid");
		String a = "SELECT buid FROM fol WHERE auid=?";
		String b = "INSERT INTO fol VALUES(?,?)";
		ArrayList<ResultSet> befocuser = new ArrayList<ResultSet>();
		try {
			stat = fo.conn.prepareStatement(a);
			stat.setString(1,name);
			rs=stat.executeQuery();
			befocuser.add(rs);
			for(int i=0;i<befocuser.size();i++){
				if (!focuser.equals(befocuser.get(i))){//没有关注过这个人
					System.out.println(befocuser.get(i));
					String befo =befocuser.get(i).toString(); //加关注
					stat.setString(1,name);
					stat.setString(2,befo);
					stat=fo.conn.prepareStatement(b);
					stat.setString(1,name);
					stat.setString(2,focuser);
					stat.executeUpdate();  //写回数据库，添加这个人
					k=1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//focusSession.setAttribute("befocuser",befocuser );
		PrintWriter out =response.getWriter();
	 if(k==1){	
			out.print("success");//给前台返回转发成功的信息
			out.flush();
			out.close();
			}
			else if(k==0){
				//response.sendRedirect("focus_error.jsp");//转发失败
				out.print("fail");
				return;
			}
	}
	public static String getname(){
		return name;
	}
}
