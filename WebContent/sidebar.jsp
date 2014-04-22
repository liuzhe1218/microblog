<%@ page language="java" import="java.io.*,java.util.*,java.sql.*,dbm.*,user.*" pageEncoding="UTF-8"%>
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

<%
String auid = (String)session.getAttribute("uid");
boolean judge;
String buid= request.getParameter("uid");
String uid = request.getParameter("uid");
String foltype = null;
foltype=request.getParameter("foltype");
focusBean fb = new focusBean(auid,buid);
judge=fb.getjudge();//判断是否是自己已关注的好友
if (uid==null||uid.equals("")){
	uid  = (String)session.getAttribute("uid");
}
Conndb conn = new Conndb();
String a = "select count(*)-1 from fol where buid=?";
String b = "select count(*)-1 from fol where auid=?";
String c = "select count(*) from mb where uid=?";
PreparedStatement sta,stb,stc;
sta = conn.conn.prepareStatement(a);
stb = conn.conn.prepareStatement(b);
stc = conn.conn.prepareStatement(c);
ResultSet rsa,rsb,rsc;
sta.setString(1, uid);
stb.setString(1, uid);
stc.setString(1, uid);
rsa = sta.executeQuery();
rsb = stb.executeQuery();
rsc = stc.executeQuery();
String ra=null;
String rb=null;
String rc=null;
if(rsa.next()){
	ra=rsa.getString(1);
}
if(rsb.next())
	rb=rsb.getString(1);
if(rsc.next())
	rc=rsc.getString(1);
%>
<div class="sidebar1">
<script type="text/javascript">
function delfol(){
		location.href="folornot.do?uid=<%=buid%>&foltype=del";
}
function addfol(){
	location.href="folornot.do?uid=<%=buid%>&foltype=fol";
}
function changemes(){
	location.href="changemessage.jsp";
}
</script>
<div id="sidebar-user">
	<table style="width:260px;margin-left:0px;padding:0px;border:0px;">
	<tr>
	<td style="padding:0px;width:100px;"><img src="<%=getpath(uid) %>" style="width:100px;height:100px;overflow:hidden;"></img></td>
	<td style="padding:0px;height:100px;width:140px;">
	<h2 style="margin-bottom:3px;"><a style="margin-left:10px;font-size:30px;color:blue;" 
	href="<%=uid%>"><%=uid %></a></h2>
	<%
    if(uid.equals(auid)){
    	
    }
    else if(judge==true) { 	//当我关注过这个好友且这个好友不是我自己才显示字符串
     %>
  	<input type="button" id="fed" value="已关注" onclick="delfol()">
  	<p>点击取消关注</p>
  	<%}else if (judge==false) {
     %>
	<input type="button" id="fno" value="未关注" onclick="addfol()">
	<p>点击添加关注</p>
	<%}%>
	<%if(uid.equals(auid)){ %>
		<input type="button" id="fme" value="修改我的个人资料" onclick="changemes()">
	<%} %>
  	</td>
  	</tr>
  	</table>
  	<table class="aboutmyinfo">
      <tr><td>粉丝数</td><td>关注者</td><td>微博数</td></tr>
      <tr>
      <td><a href="focus.jsp?uid=<%=uid%>&cktype=fans"><%=ra %></a></td>
      <td><a href="focus.jsp?uid=<%=uid%>&cktype=faning"><%=rb %></a></td>
      <td><a href="<%=uid%>"><%=rc %></a></td>
      </tr>
    </table>
</div>
    <!-- end .sidebar1 -->
</div>
