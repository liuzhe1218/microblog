package user;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbm.Conndb;

/**
 * Servlet implementation class deletefocus
 */
@WebServlet("/deletefocus")
public class focusdelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public focusdelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession deletefocusSession = request.getSession();
		String name = (String)deletefocusSession.getAttribute("uid");
		String delete ="delete from fol where auid=? and buid=?";
		String foc="INSERT INTO fol VALUES(?,?)";
		String information = request.getParameter("deletefocus");
		String a = "_";
		int b = information.indexOf(a,0);
		String c = information.substring(0,b);//类型值
		String d = information.substring(b+1);//uid
		if(c.equals("f")){//正在关注
			Conndb conndb = new Conndb();
			try {
				PreparedStatement stat = conndb.conn.prepareStatement(foc);
				stat.setString(1,name);
				stat.setString(2,d);
				stat.executeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}	
		}
		if(c.equals("d")){//正在关注
			Conndb conndb = new Conndb();
			try {
				PreparedStatement stat = conndb.conn.prepareStatement(delete);
				stat.setString(1,name);
				stat.setString(2,d);
				stat.executeUpdate();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}	
		}
	}
}
