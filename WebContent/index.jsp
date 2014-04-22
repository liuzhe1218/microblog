<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%
	String uid=(String)session.getAttribute("uid");
	if(uid==null||uid.equals("")){
		response.sendRedirect("login.jsp");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>无标题文档</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/focusmbs.js"></script>
<script type="text/javascript" src="js/mbs.js"></script>
<link rel="stylesheet" href="css/mbs.css" type="text/css" />

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
	
	<div class="header"><!-- end .header -->
    </div>
    <jsp:include page="sidebar.jsp" />
    
  	<div class="content">
  	<div id="wmb">
  	
  	<table id ="wbtitle"><tr><td>您有什么新鲜事？</td>
  	<td id="mb-num">140</td>
  	<td>
  	<button id="newmb-submit" class="newmb-submit">发布</button>
  	</td></tr>
  	</table>
  	<table>
  		<tr><td style="width:30px"></td><td>
  		<textarea id="wmbta" name="content"></textarea>
  		</td></tr>
  	</table>
  
  	</div>
  	<div id="getnewmbs" class="getmorembs">您有<span id="newmbnum"></span>条新微博，点击查看！</div>
  	<jsp:include page="getmbs.jsp" />
  	</div>
  <!-- end .content -->
  <div class="footer">
    <p>Copyright By Niyunze , Liuzhe 版权所有</p>
    <!-- end .footer --></div>
  <!-- end .container --></div>
</body>
</html>