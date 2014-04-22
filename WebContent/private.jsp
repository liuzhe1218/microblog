<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,dbm.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String myuid = (String)session.getAttribute("uid");
if(myuid==null||myuid.equals("")){
	response.sendRedirect("login.jsp");
	return;
}
String uid= request.getParameter("uid");
Conndb conn = new Conndb();
String sql = "select uid from user where uid=?";
PreparedStatement ps = conn.conn.prepareStatement(sql);
ps.setString(1, uid);
ResultSet rs = ps.executeQuery();
if(!rs.next()){
	response.sendRedirect("/404.jsp");
	return;
}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>无标题文档</title>

<link rel="stylesheet" href="css/mbs.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/mbs.js"></script>
</head>
<body>

<jsp:include page="global_header.jsp" />

<div class="container">
	
	<div id="outer-pane">
	<%-- <img id="pane" src="image.jpg"></img> --%>
	<div id="mid-pane">
	<a id="pane-hide">隐藏</a>
	<iframe id="pane" src="" onload="this.height=this.contentWindow.document.body.scrollHeight>500?500:this.contentWindow.document.body.scrollHeight"></iframe>
	</div>
	</div>
	
	<div class="header"><!-- end .header --></div>
  	<jsp:include page="sidebar.jsp" />
    <!-- end .sidebar1 -->
  <div class="content">
  	<div id="getnewmbs" class="getmorembs">您有<span id="newmbnum"></span>条新微博，点击查看！</div>
  	<jsp:include page="getidmbs.jsp" />
  </div>
  <!-- end .content -->
  <div class="footer">
    <p>Copyright By Niyunze , Liuzhe 版权所有</p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
</body>
</html>