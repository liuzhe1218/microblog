/*
 * This javascript libiary is based on Jquery!!
 */
$(document).ready(function(){
	
	/*
	//以下两段更新mb-num
	$("#wmbta").focus(function(){
		//html实现
		var mbtex =document.getElementById("wmbta").value;
		if(document.all){
			document.getElementById("mb-num").innerText=(140-mbtex.length);
		}else{
			document.getElementById("mb-num").textContent=(140-mbtex.length);
		}  
	});
	*/
	$("#wmbta").keyup(function(){
		//Jquerry实现
		var mbtex = $("#wmbta").val();
		$("#mb-num").html(140-mbtex.length);
	});
	
	//更新新微博数
	function chknewmbn(){
		var url ="getnewnum.do";
		url += "?xtamp="+new Date().getTime(); 
		$.get(url,function(newmbn){
	    		//汗，还是Jquery好用
	    		if(newmbn>"0"){
	    			$("#newmbnum").html(newmbn);
	    			$("#getnewmbs").show();
	    		}
	   		});
	}
	
	var chkup=setInterval(chknewmbn,5000);
	
	//得到更早的微博
	$(".footer").mouseenter(function(){
		var urlold="getoldmbs.jsp";
		urlold += "?xtamp="+new Date().getTime(); 
		htmlobj=$.ajax({url:urlold,async:false});
		$(".content").append(htmlobj.responseText);
		$(".mb-tmb").live("click", function(){
			$("#pane").removeAttr("height");
			$("#pane").attr("src","");
			var tmbid=$(this).attr("id");
			$("#pane").attr("src","tmb.jsp?id="+tmbid);
			$("#mid-pane").show();
		});
		$(".mb-rmb").live("click", function(){
			$("#pane").removeAttr("height");
			$("#pane").attr("src","");
			var tmbid=$(this).attr("id");
			$("#pane").attr("src","rmb.jsp?id="+tmbid);
			$("#mid-pane").show();
		});
	});
	//得到新微博
	$("#getnewmbs").click(function(){
		var urlnew="getnewmbs.jsp";
		urlnew += "?xtamp="+new Date().getTime(); 
		htmlobj=$.ajax({url:urlnew,async:false});
		$("#getnewmbs").after(htmlobj.responseText);
		$("#getnewmbs").hide();
		$(".mb-tmb").live("click", function(){
			$("#pane").removeAttr("height");
			$("#pane").attr("src","");
			var tmbid=$(this).attr("id");
			$("#pane").attr("src","tmb.jsp?id="+tmbid);
			$("#mid-pane").show();
		});
		$(".mb-rmb").live("click", function(){
			$("#pane").removeAttr("height");
			$("#pane").attr("src","");
			var tmbid=$(this).attr("id");
			$("#pane").attr("src","rmb.jsp?id="+tmbid);
			$("#mid-pane").show();
		});
	});
	//发送微博
	$("#newmb-submit").click(function(){
		txt=$("#wmbta").val();
		if(txt.length==0||txt.length>140){
			$("#wmbta").css("background-color","red");
			$("#mb-num").css("color","red");
			setTimeout(function(){$("#wmbta").css("background-color","white");},500);
			setTimeout(function(){$("#mb-num").css("color","white");},500);
		}else{
	    	$.post("wnewmb.do",{content:txt},function(result){
	    		//汗，还是Jquery好用
	    		if(result=="success"){
	    			$("#wmbta").val("");
	    			var mbtex = $("#wmbta").val();
	    			$("#mb-num").html(140-mbtex.length);
	    			alert("微博发送成功!");
	    		}
	    		else
	    			alert("微博发送失败!");
	   		});
		}
	});
});

/*
//获取微博
$(document).ready(function(){
	//打开界面得到微博
	htmlobj=$.ajax({url:"getmbs.jsp",async:false});
	$("#getnewmbs").after(htmlobj.responseText);
});
*/