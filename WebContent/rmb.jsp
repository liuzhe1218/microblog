<%@ page language="java" import="java.io.*,java.util.*,dbm.*,mb.*,java.sql.*" pageEncoding="UTF-8"%>
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
	
	
	#getnewmbs {
	width: 380px;
	text-align: center; 
	cursor: pointer;
	background: #00ABAB;
	display: none;
}

.mb{
	width:380px;
	cursor: pointer;
	border-bottom:1px solid #999999;
	border-right:1px solid #999999;
	background-color: #F0F0F0
}
.mb:hover{
	background-color: rgb(200, 222, 256);
}
.mb-table{
	width:380px;
	padding-top:5px;
	padding-bottom:5px;
}

.global_header {
	z-index:9998;
	height:35px;width:100%;
	/*
	background:url(../../../images/global_nav/global_nav_bg.png?id=1323328404357) repeat-x;
	*/
	color:#FFF;
	background-color: #000;
	background-color: rgba(0, 0, 0, 0.75);
	filter:alpha(opacity=75);
	position:fixed;
	_position:absolute;
	left:0;top:0;
}
.face{
	position: absolute;
	float:left;
	overflow:hidden;
	width:50px;
	height:50px;
	margin-left:3px;
	margin-right:3px;
	margin-top:3px;
	text-align:center;
	vertical-align:middle;
	position:relative;
	display:table-cell;
}
.face img{
	width:50px;
	height:50px;
	overflow:hidden;
}
.mb-main{
	min-height: 6px;
	margin-left:6px;
	width:336px;
}
.mb-main p{
	font-size:20px;
	margin-top: 0;
	margin-bottom: 8px;
	padding-right: 10px;
	padding-left: 5px;
	max-width:310px;
	word-wrap: break-word;
}
.uid{
	font-weight:bold;
	font-size:24px;
	padding:1px;
}
.time{
	margin-left:3px;
	margin-right:20px;
	margin-bottom:5px;
}
.mb-tmb,.mb-rmb{
	margin-right:10px;
	font-style:oblique;
	font-weight:bold;
}
.mb-tmb:hover,.mb-rmb:hover{
	background-color:red;
}
.mb-t{
	font-size:16px;
	margin-left:0px;
	margin-top:0px;
	background-color:#FF00FF;
	background-color: rgba(255,0,255,0.25);
	filter:alpha(opacity=50);
}
.mb-t blockquote{
	margin-top:5px;
	margin-bottom:5px;
	margin-left:20px;
	margin-right:10px;
	max-width:290px;
	word-wrap: break-word;
}
#con{
	padding-top:145px;
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
	<%String id=request.getParameter("id");
	String a="_";//id_trans
	int b = id.indexOf(a,0);//preuid_prembid字符串中_所在的位置
	int c = id.lastIndexOf(a);//找到最后一个'_'
    String d = id.substring(0,b);//ouid
    String f = id.substring(b+1,c);//ombid
    String type1 = id.substring(c+1,id.length());
	%>
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
	    		//汗，还是Jquery好用
	    		if(result=="success"){
	    			$("#tmbta").val("");
	    			var mbtex = $("#tmbta").val();
	    			$("#tmb-num").html(140-mbtex.length);
	    			alert("评论发送成功!");
	    		}
	    		else
	    			alert("评论发送失败!");
	   		});
		}
	});
	});
	</script>
</head>
<body>
	<div id="tmb-main">
    	<textarea id="tmbta" name="content"></textarea><button id="tmb-submit">评论</button>
    	<span id="tmb-num">140</span>
    </div>
    <div id="con">
    
    <%
  	HttpSession user_session = request.getSession();
  	String uid = (String)user_session.getAttribute("uid");
  	Conndb mydb = new Conndb();
  	String getmbs = "select type,uid,mbid,ouid,ombid,content,DATE_FORMAT(time,'%Y-%m-%d %H:%i') from mb "
  				  + "where type='r' and ouid=? and ombid=? "
  				  + "order by time desc limit 15";
  	PreparedStatement pst = mydb.conn.prepareStatement(getmbs);
  	pst.setString(1,d);
  	pst.setString(2,f);
  	ResultSet rs = pst.executeQuery();
  	String lastmbtime=null;
  	while(rs.next()){
  		String type=rs.getString(1);
  		uid=rs.getString(2);
  		String mbid=rs.getString(3);
  		String content=rs.getString(6);
  		String time=rs.getString(7);
  		
  		if(type.equals("r"))
  		{ %>
	    	<div id="<%=uid%>_<%=mbid%>" class="mb">
	  		<table class="mb-table"><tr>
    		<td class="face"><img src="<%=getpath(uid) %>"></img></td>	
    		<td class="mb-main">   
	        <p><span class="uid"><%=uid%></span>&nbsp;:&nbsp;
	  		<%=content%></p>
	  		<div class="mb-bottom">
	  		<span class="time"><%=time %></span>
	  		</div>
	  		</td></tr></table>
	    	</div>
	    <%} %>
  	<%}
  	mydb.destory(); %>
    </div>
</body>
</html>
