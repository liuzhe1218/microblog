<%@ page language="java" import="java.io.*,java.sql.*,dbm.*,mb.*" pageEncoding="UTF-8"%>
<%!
String getpath(String uid){
	String[] exted={"jpg","png","bmp"};
	for(int x=0;x<3;x++){
		File file = new File(this.getServletContext().getRealPath("/")+"FileUploaded/"+uid+'.'+exted[x]);
		if(file.exists())
			return "FileUploaded/"+uid+"."+exted[x];
	}
	return "image.jpg";
}%>	
  	<%
  	HttpSession user_session = request.getSession();
  	String uid = (String)user_session.getAttribute("uid");
  	
  	String firstmb = (String)user_session.getAttribute("firstmb");
  	if(firstmb==null){
  		//user_session.setAttribute("firstmb", "0");
  		response.sendRedirect("404.jsp");
  		return;
  	}
  	Conndb mydb = new Conndb();
  	String getmbs = "select type,uid,mbid,ouid,ombid,content,DATE_FORMAT(time,'%Y-%m-%d %H:%i'),time from mb "
  				  + "where type!='r' and uid in (select buid from fol where auid=?) "
  				  + "and time<? "
  				  + "order by time desc limit 15";
  	PreparedStatement pst = mydb.conn.prepareStatement(getmbs);
  	pst.setString(1,uid);
  	pst.setString(2,firstmb);
  	ResultSet rs = pst.executeQuery();
  	while(rs.next()){
  		String type=rs.getString(1);
  		uid=rs.getString(2);
  		String mbid=rs.getString(3);
  		String content=rs.getString(6);
  		String time=rs.getString(7);
  		if(type.equals("o")){
	  	%>
	  	<div id="<%=uid%>_<%=mbid%>" class="mb">
	  		<table class="mb-table"><tr>
    		<td class="face"><img src="<%=getpath(uid) %>"></img></td>	
    		<td class="mb-main">   
	        <p><a href="<%=uid %>"><span class="uid"><%=uid%></span></a>&nbsp;:&nbsp;
	  		<%=content%></p>
	  		<div class="mb-bottom">
	  		<span class="time"><%=time %></span>
	  		<a id="<%=uid%>_<%=mbid%>_t" class="mb-tmb">转发</a><a id="<%=uid%>_<%=mbid%>_r" class="mb-rmb">评论</a>
	  		</div>
	  		</td></tr></table>
	    </div>
	    <%}else if(type.equals("t")){%>
	    <div id="<%=uid%>_<%=mbid%>" class="mb">
	    <table class="mb-table"><tr>
    		<td class="face"><img src="<%=getpath(uid) %>"></img></td>
    		<td class="mb-main">   
	        <p><a href="<%=uid %>"><span class="uid"><%=uid%></span></a>&nbsp;:&nbsp;
	  		<%=content%></p>
	  		<%String ouid=rs.getString(4);
	  		String ombid=rs.getString(5);
	  		Umbid temp = new Umbid();
	  		ResultSet rst=temp.getmb(ouid,ombid);
	  		String ttont=null;
	  		String ttime=null;
	  		if(rst.next()){
	  			ttont=rst.getString(1);
	  			ttime=rst.getString(2);
	  			temp.destory();
	  		}%>
	  		<div class="mb-t">
	  		<blockquote><a href="<%=uid %>"><b><%=ouid%></b></a>&nbsp;:&nbsp;<%=ttont %>
	  		<div class="time"><%=ttime %></div>
	  		</blockquote>
	  		</div>
	  		<div class="mb-bottom">
	  		<span class="time"><%=time %></span>
	  		<a id="<%=ouid%>_<%=ombid%>_t" class="mb-tmb">转发</a><a id="<%=uid%>_<%=mbid%>_r" class="mb-rmb">评论</a>
	  		</div>
	  		</td></tr></table>
	    </div>
	    <%}else{ %>
	    	
	    <%}
  		firstmb = new String(rs.getString(8));
  	}
  	user_session.setAttribute("firstmb", firstmb);
  	mydb.destory(); 
  	%>
