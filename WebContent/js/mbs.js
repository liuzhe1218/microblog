/*
 * This javascript libiary is based on Jquery!!
 */
$(document).ready(function(){
		
	//转发微博
	$(".mb-tmb").click(function(){
		$("#pane").removeAttr("height");
		$("#pane").attr("src","");
		var tmbid=$(this).attr("id");
		$("#pane").attr("src","tmb.jsp?id="+tmbid);
		$("#mid-pane").show();
	});
	//回复
	$(".mb-rmb").click(function(){
		$("#pane").removeAttr("height");
		$("#pane").attr("src","");
		var tmbid=$(this).attr("id");
		$("#pane").attr("src","rmb.jsp?id="+tmbid);
		$("#mid-pane").show();
		
	});
	$("#pane-hide").click(function(){
		$("#mid-pane").hide();
		$("#pane").attr("src","");
	});
});

/*

//固定pane但是闪烁
	window.onscroll = function (){
		if(document.body.scrollTop)
			$("#outer-pane").css("margin-top",document.body.scrollTop);
		else if (document.documentElement && document.documentElement.scrollTop)
			$("#outer-pane").css("margin-top",document.documentElement.scrollTop);
	};


//用 .mb:hover 替换了该方法
$(".mb").mouseover(function(){
	$(this).css("background-color","rgb(200, 222, 256)");
});
$(".mb").mouseout(function(){
	$(this).css("background-color","#FFF");
});
*/