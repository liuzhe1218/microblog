<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,dbm.*,mb.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String myuid = (String) session.getAttribute("uid");
	String uid = request.getParameter("uid");
	String cktype = request.getParameter("cktype");
	Conndb mydb = new Conndb();
	String sqlfaning = "select buid from fol where buid!=auid and auid=?";
	String sqlfans = "select auid from fol where buid!=auid and buid=?";
	String sqllastmb = "select type,uid,mbid,ouid,ombid,content,DATE_FORMAT(time,'%Y-%m-%d %H:%i'),time from mb "
			+ "where type!='r' and uid=? "
			+ "order by time desc limit 1";
	PreparedStatement ps = null;
	PreparedStatement pslastmb = null;
	if (cktype.equals("faning"))
		ps = mydb.conn.prepareStatement(sqlfaning);
	else if (cktype.equals("fans")) {
		ps = mydb.conn.prepareStatement(sqlfans);
	} else {
		response.sendRedirect("");
		return;
	}
	//PreparedStatement ps2 = conn.conn.prepareStatement(sql);
	ps.setString(1, uid);
	ResultSet rs = ps.executeQuery();
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
				<iframe id="pane" src=""
					onload="this.height=this.contentWindow.document.body.scrollHeight>500?500:this.contentWindow.document.body.scrollHeight"></iframe>
			</div>
		</div>

		<div class="header">
			<!-- end .header -->
		</div>
		<jsp:include page="sidebar.jsp" />
		<!-- end .sidebar1 -->
		<div class="content">
			<%
				String person = null;
				while (rs.next()) {
					person = rs.getString(1);
					pslastmb = mydb.conn.prepareStatement(sqllastmb);
					pslastmb.setString(1, person);
					ResultSet rsp = pslastmb.executeQuery();
					if (rsp.next()) {
						String type = rsp.getString(1);
						uid = rsp.getString(2);
						String mbid = rsp.getString(3);
						String content = rsp.getString(6);
						String time = rsp.getString(7);
						if (type.equals("o")) {
			%>
			<div id="<%=uid%>_<%=mbid%>" class="mb">
				<table class="mb-table">
					<tr>
						<td class="face"><img src="image.jpg"></img></td>
						<td class="mb-main">
							<p>
								<a href="<%=uid%>"><span class="uid"><%=uid%></span> </a>&nbsp;:&nbsp;
								<%=content%></p>
							<div class="mb-bottom">
								<span class="time"><%=time%></span> <a id="<%=uid%>_<%=mbid%>_t"
									class="mb-tmb">转发</a><a id="<%=uid%>_<%=mbid%>_r"
									class="mb-rmb">评论</a>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<%
				} else if (type.equals("t")) {
			%>
			<div id="<%=uid%>_<%=mbid%>" class="mb">
				<table class="mb-table">
					<tr>
						<td class="face"><img src="image.jpg"></img></td>
						<td class="mb-main">
							<p>
								<a href="<%=uid%>"><span class="uid"><%=uid%></span> </a>&nbsp;:&nbsp;
								<%=content%></p> <%
 	String ouid = rsp.getString(4);
 				String ombid = rsp.getString(5);
 				Umbid temp = new Umbid();
 				ResultSet rst = temp.getmb(ouid, ombid);
 				String ttont = null;
 				String ttime = null;
 				if (rst.next()) {
 					ttont = rst.getString(1);
 					ttime = rst.getString(2);
 					temp.destory();
 				}
 %>
							<div class="mb-t">
								<blockquote>
									<a href="<%=ouid%>"><b><%=ouid%></b> </a>&nbsp;:&nbsp;<%=ttont%>
									<div class="time"><%=ttime%></div>
								</blockquote>
							</div>
							<div class="mb-bottom">
								<span class="time"><%=time%></span> <a
									id="<%=ouid%>_<%=ombid%>_t" class="mb-tmb">转发</a><a
									id="<%=uid%>_<%=mbid%>_r" class="mb-rmb">评论</a>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<%
				} else {
			%>

			<%
				}
			%>
			<%
				} else {%>
					<div id="<%=person%>_0" class="mb">
					<table class="mb-table">
						<tr>
							<td class="face"><img src="image.jpg"></img></td>
							<td class="mb-main">
								<p>
									<a href="<%=person%>"><span class="uid"><%=person%></span> </a>&nbsp;:&nbsp;
									<em style="color:green;">【这个人比较懒，什么也没留下】</em>
								</p>
								<div class="mb-bottom">
									<span class="time"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
					<%}
				}
				mydb.destory();
			%>


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