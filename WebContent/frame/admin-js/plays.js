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
		]],
		url: '../api/play.jsp?type=getAlladmin',
		done: function() {
			layer.closeAll();
		}
	});
	
});
