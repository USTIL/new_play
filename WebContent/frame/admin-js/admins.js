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
		]],
		url: '../api/admin.jsp?type=getAll',
		done: function() {
			layer.closeAll();
		}
	});
	
});
