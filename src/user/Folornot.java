package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dbm.*;
/**
 * Servlet implementation class Folornot
 */
@WebServlet("/Folornot")
public class Folornot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Folornot() {
        super();
        // TODO Auto-generated constructor stub
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String foltype = null;
		HttpSession session = request.getSession();
		foltype=request.getParameter("foltype");
		String auid = (String)session.getAttribute("uid");
		String buid= request.getParameter("uid");
		focusBean fb = new focusBean(auid,buid);
		if(foltype==null){}
		else if(foltype.equals("fol"))
			fb.addfocus(auid, buid);
		else if(foltype.equals("del"))
			fb.delfocus(auid, buid);
		else{}
		response.sendRedirect("private.jsp?uid="+buid);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
