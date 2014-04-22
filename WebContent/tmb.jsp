<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
	<!--
	body{
		margin:0px;
		background-color:#9F9;
	}
	#tmb-main{
		position:absolute;
		margin-left:0px;
		margin-top:0px;
		width:376px;
	}
	#tmbta{
		font-size:18px;
		width:376px;
		height:100px;
		resize:none;
	}
	#tmb-submit{
		width:80px;
		height:36px;
		font-size:20px;
		font-weight:bold;
	}
	#tmb-num {
	padding-top:0px;
	padding-left:20px;
	font-size:28px;
	width:180px;
	color:white;
	}
	-->
	</style>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript">
	//检查长度
	$(document).ready(function(){
	$("#tmbta").keyup(function(){
		//Jquerry实现
		var mbtex = $("#tmbta").val();
		$("#tmb-num").html(140-mbtex.length);
	});
	<%String id=request.getParameter("id");%>
	var id="<%=id%>";
	//发送
	$("#tmb-submit").click(function(){
		txt=$("#tmbta").val();
		if(txt.length==0||txt.length>140){
			$("#tmbta").css("background-color","red");
			$("#tmb-num").css("color","red");
			setTimeout(function(){$("#tmbta").css("background-color","white");},500);
			setTimeout(function(){$("#tmb-num").css("color","white");},500);
		}else{
	    	$.post("trnewmb.do",{content:txt,id:id},function(result){
	    		//id为 ouid_ombid_t
	    		if(result=="success"){
	    			$("#tmbta").val("");
	    			var mbtex = $("#tmbta").val();
	    			$("#tmb-num").html(140-mbtex.length);
	    			alert("转发成功!");
	    		}
	    		else
	    			alert("转发失败!");
	   		});
		}
	});
	});
	</script>
</head>
<body>
	<div id="tmb-main">
    	<textarea id="tmbta" name="content"></textarea><button id="tmb-submit">发布</button>
    	<span id="tmb-num">140</span>
    </div>
</body>
</html>
