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
			{field: 'username', title: '用户名', width: 300, align: 'center'},
			{field: 'name', title: '姓名', width: 200, align: 'center'},
			{fixed: 'right', title: '操作', width:150, align:'center', toolbar: '#barDemo'}
		]],
		url: '../api/admin.jsp?type=getAll',
		done: function() {
			layer.closeAll();
		}
	});
	
	table.on('tool(table1)', function(obj){
		var data = obj.data;
		var layEvent = obj.event;
		var tr = obj.tr;

		if(layEvent === 'del'){
			layer.confirm('真的删除管理员'+data.name+'吗？', function(index){
				layer.load(0, {shade: false});
				$.post('../api/admin.jsp?type=delete', {
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
