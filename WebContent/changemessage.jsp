<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*,dbm.*,java.util.*,encrypt.GetMD5" errorPage=""%>
<%
	PreparedStatement stat, stat1;
	ResultSet rs;
	String uid = (String) session.getAttribute("uid");
	Conndb conndb = new Conndb();
	//String uid1= request.getParameter("username");
	//String email1=request.getParameter("email");
	//String pswd1=request.getParameter("password");
	String sel = "select uid,email,pswd from user where uid=?";
	//String update="update user set uid=?,email=?,pswd=? where uid=?";
	stat = conndb.conn.prepareStatement(sel);
	//stat1=conndb.conn.prepareStatement(update);
	//String passwd=(new GetMD5()).getMD5(uid1 + pswd1);
	stat.setString(1, uid);
	//stat1.setString(1,uid1);
	//stat1.setString(2,email1);
	//stat1.setString(3,passwd);
	rs = stat.executeQuery();
	//stat1.executeUpdate();
	if (rs.next()) {
		String email = rs.getString(2);
		String pswd = rs.getString(3);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>个人信息中心</title>
<link rel="stylesheet" href="css/mbs.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js">
	
</script>
<script language="javascript">
	function checkName() {
		var name = document.getElementById("name");
		var pic = document.getElementById("pic");
		var checkName = document.getElementById("checkName");
		var patrn = /^[a-zA-Z_]{1}\w{5,16}$/;
		if (!patrn.exec(name.value)) {
			checkName.style.color = "red";
			checkName.innerHTML = "*用户名输入有误!";
			return false;
		} else {
			checkName.style.color = "green";
			checkName.innerHTML = "*输入正确";
			return true;
		}
	}

	function checkPassword() {
		var pwd1 = document.getElementById("pwd1");
		var pwdRemind = document.getElementById("pwdRemind");
		var patrn = /^[a-z,A-Z,0-9]{6,15}$/;
		if (!patrn.exec(pwd1.value)) {
			pwdRemind.style.color = "red";
			pwdRemind.innerHTML = "*密码格式输入有误!";
			return false;
		} else {
			pwdRemind.style.color = "green";
			pwdRemind.innerHTML = "*密码输入正确！";
			return true;
		}
	}
	//确认密码
	function checkPwd() {
		var pwd1 = document.getElementById("pwd1");
		var pwd2 = document.getElementById("pwd2");
		var checkPwd = document.getElementById("checkPwd");
		if (pwd1.value != pwd2.value) {
			checkPwd.style.color = "red";
			checkPwd.innerHTML = "*两次密码输入不一致!";
			return false;
		} else {
			checkPwd.style.color = "green";
			checkPwd.innerHTML = "*两次密码输入一致!";
			return true;
		}
	}

	function checkMail() {
		var email = document.getElementById("email");
		var patrn = /((\w)|[-]|[.])+@(((\w)|[-])+[.])+[a-z]{2,4}$/;
		var checkMail = document.getElementById("checkMail");
		if (!patrn.exec(email.value)) {
			checkMail.style.color = "red";
			checkMail.innerHTML = "*邮箱格式输入有误!";
			return false;
		} else {
			checkMail.style.color = "green";
			checkMail.innerHTML = "*邮箱输入正确!";
			return true;
		}
	}

	function clearRN() {
		var checkName = document.getElementById("checkName");
		checkName.style.color = "black";
		checkName.innerHTML = "*由英文字母或下划线(6-15)字符组成";
	}

	function clearPwd() {
		var checkPwd = document.getElementById("checkPwd");
		var pwdRemind = document.getElementById("pwdRemind");
		checkPwd.style.color = "black";
		checkPwd.innerHTML = "*由英文字母和数字(6-15)字符组成";
		pwdRemind.innerHTML = "*由英文字母和数字(6-15)字符组成！";
	}

	function clearMail() {
		var checkMail = document.getElementById("checkMail");
		checkMail.style.color = "black";
		checkMail.innerHTML = "*请输入正确的邮箱地址! 如：lenovo@163.com";
	}

	function check(form) {
		if (form.name.value == "") {
			alert("请输入注册用户名!");
			form.name.focus();
			return false;
		}
		if (form.pwd1.value == "") {
			alert("请输入密码!");
			form.pwd1.focus();
			return false;
		}
		if (form.pwd1.value != form.pwd2.value) {
			alert("两次输入密码不一致!请重新输入！");
			form.pwd1.focus();
			return false;
		}

		var email = document.getElementById("email");
		var patrn = /((\w)|[-]|[.])+@(((\w)|[-])+[.])+[a-z]{2,4}$/;
		var checkMail = document.getElementById("checkMail");
		if (!patrn.exec(email.value)) {
			checkMail.style.color = "red";
			alert("请输入正确的邮箱地址！");
			return false;
		} else {
			checkMail.style.color = "green";
			checkMail.innerHTML = "*邮箱输入正确!";
			return true;
		}

	}
	function picture() {
		location.href = "uppic.jsp";
	}
</script>
<style type="text/css">
body {
	font-size: 14px;
}
</style>
</head>
<body>
	<jsp:include page="global_header.jsp" />
	<div class="container">

		<div class="header">
			<a href="#"><img /></a>
			<!-- end .header -->
		</div>
		<div class="sidebar1">
			<!-- end .sidebar1 -->
		</div>
		<div class="content">
			<div>
				<h2 align="center">修改个人信息</h2>
				<form id="sa" name="form1" method="post" action="changemessage.do">
					<table id="logintb" align="left" border="1px" cellspacing="0"
						cellpadding="0">
						<tbody>
							<tr>
								<td width="100px" height="30" align="left">修改密码：</td>
								<td width="200px"><input type="password" id="pwd1"
									name="password" class="contact_input" onfocus="clearPwd()"
									onblur="checkPassword()" size="22" /></td>
								<td colspan="2" id="pwdRemind">*由英文字母和数字(6-16)字符组成 不得少于6个字符</td>
							</tr>

							<tr>
								<td height="30" align="left">确认密码：</td>
								<td><input type="password" id="pwd2" name="passwordck"
									class="contact_input" onblur="checkPwd()" size="22" /></td>
								<td colspan="2" id="checkPwd"></td>
							</tr>
							<tr>
								<td height="30" align="left">修改Email：</td>
								<td><input type="text" id="email" name="email"
									class="contact_input" onblur="checkMail()"
									onfocus="clearMail()" /></td>
								<td colspan="2" id="checkMail">*输入正确的Email地址 如：<span
									style="color: #00C; font-size: 13px">lenovo@163.com</span></td>
							</tr>

							<tr>
								<td height="30" align="left">
								<input type="button" name="button2" id="button2" value="上传头像"
										onclick="picture()" /></td>
								<td><input type="reset" name="button" id="button"
									value="重新填写" /></td>
								<td colspan="2"><input type="submit" name="button3"
									id="button3" value="提交修改" onclick="check(form1)" /></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<div class="footer">
			<p></p>
			<!-- end .footer -->
		</div>
		<!-- end .container -->
	</div>
</body>
</html>
