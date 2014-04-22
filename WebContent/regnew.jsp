<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>注册页面</title>
<link rel="stylesheet" href="css/mbs.css" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script language="javascript">
	function checkName() {
		var name = document.getElementById("name");
		//var pic = document.getElementById("pic");
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
		checkMail.innerHTML = "*请输入正确的邮箱地址!<br />如：lenovo@163.com";
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
</script>

</head>


<body>
	<jsp:include page="global_header.jsp" />
	<div class="container">

		<div class="header">
			<a href="#"><img src="" alt="在此处插入徽标" name="Insert_logo"
				width="180" height="90" id="Insert_logo"
				style="background: #C6D580; display:block;" /> </a>
			<!-- end .header -->
		</div>

		<div class="sidebar1">
			<!-- end .sidebar1 -->
		</div>

		<div class="content">
			<h3 height="10px" align="center"></h3>
			<h3 width="560px" align="center">请填写信息</h3>
			<form id="sa" name="form1" method="post" action="regnew.do">
				<table id="logintb" align="left" border="1px" cellspacing="0"
					cellpadding="0">
					<tr>
						<td min-width="10px" height="30" align="right"><b>用户名：</b>&nbsp;</td>
						<td width="170px"><input type="text" id="name" name="username"
							class="contact_input" onblur="checkName()" onfocus="clearRN()" size="21" /></td>
						<td width="280px" id="checkName">*由英文字母和数字(6-16)字符组成</td>
					</tr>

					<tr>
						<td height="30" align="right"><b>密码：</b>&nbsp;</td>
						<td><input type="password" id="pwd1" name="password"
							class="contact_input" onfocus="clearPwd()"
							onblur="checkPassword()" size="22" />
						</td>
						<td colspan="2" id="pwdRemind">*由英文字母和数字(6-16)字符组成<br />不得少于6个字符</td>
					</tr>

					<tr>
						<td height="30" align="right"><b>确认密码：</b>&nbsp;</td>
						<td><input type="password" id="pwd2" name="passwordck"
							class="contact_input" onblur="checkPwd()" size="22" />
						</td>
						<td colspan="2" id="checkPwd">&nbsp;</td>
					</tr>

					<tr>
						<td height="30" align="right"><b>性别：</b>&nbsp;</td>
						<td>
							<p>

								<input type="radio" name="sex" value="m" id="RadioGroup1_0" />
								男 <input type="radio" name="sex" value="f" id="RadioGroup1_1" />
								女 <br />
							</p>
						</td>
						<td colspan="2">&nbsp;</td>
					</tr>

					<tr>
						<td height="30" ><b>Email地址：</b></td>
						<td><input type="text" id="email" name="email"
							class="contact_input" onblur="checkMail()" onfocus="clearMail()" />
						</td>
						<td colspan="2" id="checkMail">*输入正确的Email地址<br />如：<span
							style="color:#00C; font-size:13px">lenovo@163.com</span></td>
					</tr>

					<tr>
						<td height="44" align="right">&nbsp;</td>
						<td><input type="reset" name="button" id="button"
							value="重新填写" />
						</td>
						<td colspan="2"><input type="submit" name="button2"
							id="button2" value="提交注册" onclick="check(form1)" />
						</td>
					</tr>
				</table>
			</form>

		</div>
		<div class="footer">
			<p>Copyright By Niyunze , Liuzhe 版权所有</p>
			<!-- end .footer -->
		</div>
		<!-- end .container -->
	</div>
</body>
</html>