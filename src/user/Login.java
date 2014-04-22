package user;

import java.io.IOException;
//import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dbm.Conndb;

import encrypt.GetMD5;
//import java.io.UnsupportedEncodingException;
//import java.security.*;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public Login() {
		super();
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// deny get and return 404
		response.sendError(404);
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//RequestDispatcher rd = null;
		HttpSession login_session = request.getSession();
		String uid = request.getParameter("name");//把name的值传给uid
		String pswd = request.getParameter("pswd");
		//System.out.println(uid);
		//System.out.println(pswd);
		pswd = new String((new GetMD5()).getMD5(uid + pswd));//得到一个用MD5加密后的名字密码字符创
		Conndb newlogin = new Conndb();//实例化一个javaBean
		String preparesql = "select uid,pswd from user where uid=? and pswd=?";
		ResultSet rs = null;
		try {
			PreparedStatement ps = newlogin.conn.prepareStatement(preparesql);
			ps.setString(1, uid);
			ps.setString(2, pswd);
			rs = ps.executeQuery();//这就是一个查询过程
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			response.sendRedirect("Login.jsp");
			e1.printStackTrace();
			return;
		}
		try {
			if (rs.next()) {//用户查询结果集显示存在该用户
				//login success 
				uid = new String(rs.getString(1));
				login_session.setAttribute("uid", uid);//登陆时记录当前登陆用户名，然后可以直接调用
				//System.out.println(uid);
				response.sendRedirect("index.jsp");
				return;
			} else {
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("login.jsp");
			return;
		}finally{
			newlogin.destory();
			newlogin = null;
		}
	}
}
