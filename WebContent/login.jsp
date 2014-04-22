<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>微博登陆页面</title>
<link rel="stylesheet" href="css/mbs.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js">
	
</script>
<script type="text/javascript">
	function turnreg() {
		location.href = "regnew.jsp";
	}
</script>
</head>
<body>
	<body>
		<jsp:include page="global_header.jsp" />

		<div class="container">

			<div class="header">
				<!-- end .header -->
			</div>

			<div class="sidebar1">
				<!-- end .sidebar1 -->
			</div>

			<div class="content">
				<h3 height="10px" align="center"></h3>
				<h3 width="560px" align="center">请填写登陆信息</h3>
				<div style=" width:300px; height:200px; margin-left:130px;">
					<form method="post" action="login.do">
						<table border="1px" bordercolor="#0099FF" bgcolor='#CCFFFF'>
							<tr>
								<td width="40%">用户名:</td>
								<td width="150px"><input width="150px" type="text" name="name" />
								</td>
							</tr>
							<tr>
								<td width="40%">密码</td>
								<td width="150px"><input width="150px" type="password" name="pswd" />
								</td>
								<tr>
									<td colspan="4" align="center"><input type="submit"
										value="登陆">&nbsp;&nbsp;&nbsp;&nbsp; <input
											type="reset" value="清空">&nbsp;&nbsp;&nbsp;&nbsp; <input
												type="button" value="注册" onclick="turnreg()">
								</tr>
						</table>
					</form>
				</div>

			</div>
			<div class="footer">
				<p>Copyright By Niyunze , Liuzhe 版权所有</p>
				<!-- end .footer -->
			</div>
			<!-- end .container -->
		</div>
	</body>
</html>