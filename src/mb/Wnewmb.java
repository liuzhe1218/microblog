package mb;

import dbm.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Wnewmb extends HttpServlet {
	public Wnewmb() {
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
		ps = null;
		conndb = null;
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		return;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
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
		String uid = (String) user_session.getAttribute("uid");
		if (uid == null) {
			destroy();
			return;
		}
		String content = request.getParameter("content");
		if (content == null || content.length() <= 0 || content.length() > 140) {
			destroy();
			return;
		}
		int success = 0;
		try {
			ps.setString(1, "o");
			ps.setString(2, uid);
			ps.setString(3, htmlspecialchars(content));
			success = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.destroy();
			return;
		}
		if (success <= 0) {
			this.destroy();
			return;
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		// System.out.println("2"+content+"|"+content.length());
		out.print("success");
		out.flush();
		out.close();
		this.destroy();
		return;
	}

	private String htmlspecialchars(String str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll(",", "&#44");
		str = str.replaceAll("'", "&apos;");
		System.out.println(str);
		return str;
	}

	public void init() throws ServletException {
	}

	private Conndb conndb;
	private PreparedStatement ps;
	private String sql = "insert into mb(type,uid,content) values(?,?,?)";
}
