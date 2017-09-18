// JavaScript Document
layui.use(['form', 'layer'], function(){
	var form = layui.form
	,layer = layui.layer;
	form.on('submit(demo1)', function(medata){
		var medata = JSON.stringify(medata.field);
	    var data = JSON.parse(medata);
		if (data.username == "" || data.password == "") {
			layer.msg("用户名或密码不能为空");
		} else {
			$.post("../api/login.jsp?type=admin", {
				username: data.username,
				password: data.password
			}, function(data) {
				if (data.indexOf("null") >= 0) {
					layer.msg("用户名或密码不能为空");
				} else if (data.indexOf("fail") >= 0) {
					layer.msg("用户名或密码错误", {icon:2});
				} else if (data.indexOf("success") >= 0) {
					window.location.href="index.jsp";
				} else {
					layer.msg("未知错误");
				}
			});
		}
		return false;
	});
});
