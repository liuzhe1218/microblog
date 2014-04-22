<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%
	String uid = (String) session.getAttribute("uid");
	if (uid == null || uid.equals("")) {
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
<link rel="stylesheet" href="css/mbs.css" type="text/css" />

</head>
<body>

	<jsp:include page="global_header.jsp" />

	<div class="container">
		<div id="outer-pane">
			<%-- <img id="pane" src="image.jpg"></img> --%>
			<div id="mid-pane">
				<a id="pane-hide">隐藏</a>

				<iframe id="pane" src=""
					onload="this.height=this.contentWindow.document.body.scrollHeight>500?500:this.contentWindow.document.body.scrollHeight"></iframe>
			</div>
		</div>

		<div class="header">
			<!-- end .header -->
		</div>
		<jsp:include page="sidebar.jsp" />

		<div class="content">
			<h1 align="center">更换照片</h1>
			<img style="position:absolute;margin-left:50px;" src="man.png"></img>
			<form name="form1" method="post" action="fileupload.do" id="form1"
				enctype="multipart/form-data">
				<table style="position:absolute;margin-left:300px;">
					<tr><td>请选择新的照片文件，</td></tr><tr><td>文件需小于2.5MB</td></tr>
					<tr><td></td></tr>
					<tr><td><input type="file" name="fuPhoto" id="fuPhoto" title="选择照片" /></td></tr>
					<tr><td><input type="submit" name="btnUpload" value="上 传" id="btnUpload" /></td></tr>
				</table>
			</form>
		</div>
		<!-- end .content -->
		<div class="footer">
			<p>Copyright By Niyunze , Liuzhe 版权所有</p>
			<!-- end .footer -->
		</div>
		<!-- end .container -->
	</div>
</body>
</html>
