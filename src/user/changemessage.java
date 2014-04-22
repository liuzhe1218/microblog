package user;

import java.io.IOException;
//import java.io.PrintWriter;
//import javax.servlet.*;
//import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import dbm.Conndb;

import encrypt.GetMD5;

//import java.io.UnsupportedEncodingException;
//import java.security.*;

/**
* Servlet implementation class Login
*/

public class changemessage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public changemessage() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//System.out.println(1);
		HttpSession changesession = request.getSession();
		String uid = (String)changesession.getAttribute("uid");
		String num = uid;
		String pswd = request.getParameter("password");
		String pswdck = request.getParameter("passwordck");
		String email = request.getParameter("email");
      char a[] = num.toCharArray();
      char b[] = pswd.toCharArray();
      String regex="\\w{1,}@\\w{1,}\56\\w{1,}";//注释
		//     || !isNumber(num)
		if (num == null || num.length() > 16 || num.length() < 1) {
			response.sendRedirect("changemessage.jsp");
			return;
		}
		else {
			for (int i=0;i<num.length();i++){
				if ((a[i]<'a'&&a[i]>'z')||(a[i]<'A'&&a[i]>'Z')||(a[i]<'0'&&a[i]>'9')){
					response.sendRedirect("changemessage.jsp");
					return;
				}		
			}
		}	    
		/*if (name == null || name.length() > 16 || name.length() < 1) {
			response.sendRedirect("changemessage.jsp");
			return;
		}*/
		if (email == null || email.length() > 45) {
			response.sendRedirect("changemessage.jsp");
			return;
		}
		else if(!email.matches(regex)){
			response.sendRedirect("changemessage.jsp");
			return;
		}
		if (pswd == null || pswdck == null || pswd.length() < 3
				|| pswd.length() > 50) {
			response.sendRedirect("changemessage.jsp");
			return;
		}
		else {
			for (int i=0;i<pswd.length();i++){
				if ((b[i]<'a'&&b[i]>'z')||(b[i]<'A'&&b[i]>'Z')||(b[i]<'0'&&b[i]>'9')){
					response.sendRedirect("changemessage.jsp");
					return;
				}		
			}
		}
		if (!pswd.equals(pswdck)) {
			response.sendRedirect("changemessage.jsp");
			return;
		}
		String passwd = new String((new GetMD5()).getMD5(num + pswd));

		Conndb newlogin = new Conndb(); // 
		PreparedStatement stat;
		//String sqlinsert = "insert into user values(?,?,?,?)";
		String fol = "update user set uid=?,pswd=?,email=? where uid =?";
		try {
			//stat = newlogin.conn.prepareStatement(sqlinsert);
			stat = newlogin.conn.prepareStatement(fol);
		    //stat.setString(1,num);
		    //stat.setString(3,email);
		    //stat.setString(4,passwd);
		    //stat.executeUpdate();
		    stat.setString(1,num);
		    stat.setString(2,passwd);
		    stat.setString(3,email);
		    stat.setString(4,uid);
		    stat.executeUpdate();		    
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			newlogin.destory();
			response.sendRedirect("changemessage.jsp");
		}finally{
			response.sendRedirect("index.jsp");
			destroy();
			newlogin = null;
		}
		//response.sendRedirect("index.jsp");
	}
}