// JavaScript Document
layui.use(['layer', 'table'], function() {
	var layer = layui.layer,
		table = layui.table;
	
	var h = $(document).height()-20;
	
	layer.load(0, {shade: false});
	
	table.render({
		elem: '#table1',
		page: true,
		limit: 20,
		height: h,
		cols: [[
			{field: 'id', title: 'ID', width: 80, align: 'center'},
			{field: 'title', title: '标题', width: 300, align: 'center'},
			{field: 'cont', title: '简介', width: 400, align: 'center'},
			{field: 'date', title: '日期', width: 150, align: 'center'},
			{fixed: 'right', title: '操作', width:150, align:'center', toolbar: '#barDemo'}
		]],
		url: '../api/play.jsp?type=getAlladmin',
		done: function() {
			layer.closeAll();
		}
	});
	
	table.on('tool(table1)', function(obj){
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;

		if(layEvent === 'detail'){
			
		} else if(layEvent === 'del'){
			layer.confirm('真的删除'+data.title+'吗？', function(index){
				layer.load(0, {shade: false});
				$.post('../api/play.jsp?type=delete', {
					id: data.id
				}, function(data) {
					layer.closeAll();
					if (data.indexOf("fail") >= 0) {
						layer.msg('删除失败', {icon:2});
					} else if (data.indexOf("success") >= 0) {
						layer.msg('删除成功', {icon:1});
						obj.del();
			    		layer.close(index);
					}
				});
			});
		}
	});
	
});
