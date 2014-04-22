<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String uid = null;
	uid = (String) session.getAttribute("uid");
%>
<div class="global_header">
	<%
		if (uid == null || uid.equals("")) {
	%>
	<table>
		<tr>
			<td><a href="index.jsp"><img src="logo.jpg" alt="buptdb"
					name="Insert_logo" width="35" height="35" id="Insert_logo"
					style="background: #C6D580; display:block;" />
			</a>
			</td>
			<td>buptdb微博</td>
			<td width="30px"></td>
			<td>您还没有登陆，请先登陆！</a>
			</td>
			</td>
		</tr>
	</table>
	<%} else {%>

	<table>
		<tr>
			<td><a href="index.jsp"><img src="logo.jpg" alt="buptdb"
					name="Insert_logo" width="35" height="35" id="Insert_logo"
					style="background: #C6D580; display:block;" />
			</a>
			</td>
			<td>buptdb微博</td>
			<td width="10px"></td>
			<td>欢迎:&nbsp;&nbsp;<a id="head-uid" href="<%=uid%>"><%=uid %></a>
			</td>
			<td width="10px"></td>
			<td><a href="logout.jsp" style="color:white">注销</a>
			<td width="30px"></td>
			<td ><a href="/" style="color:white">返回主页</a>
			</td>
			<td width="20px"></td>
			<td ><a href="#" style="color:white">返回顶部</a>
			</td>
		</tr>
	</table>
	<%}%>
</div>
