// JavaScript Document
layui.use('laydate', function(){
    var laydate = layui.laydate;
  
    laydate.render({
        elem: '#date',
		format: 'yyyy-MM-dd'
    });
});

function addplay() {
	layui.use('layer', function() {
		var layer = layui.layer;
		
		var title = $('#title').val();
		var cont = $('#cont').val();
		var date = $('#date').val();
		
		if (title == "" || cont == "" || date == "") {
			layer.msg('标题简介日期不能为空');
		} else {
		
			layer.load(0, {shade: false});

			$.post('../api/play.jsp?type=addplay', {
				title: title,
				cont: cont,
				date: date
			}, function(data) {
				layer.closeAll();
				if (data.indexOf("success") >= 0) {
					layer.msg('添加成功', {icon: 1});
				} else if (data.indexOf("null") >= 0) {
					layer.msg('标题简介日期不能为空');
				} else if (data.indexOf("error") >= 0) {
					layer.msg('添加失败', {icon: 2});
				} else {
					layer.msg('未知错误');
				}
			});
		}
	});
}
