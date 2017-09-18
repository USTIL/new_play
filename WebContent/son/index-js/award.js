// JavaScript Document
function getUrlParam(name){   
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");  
    var r = window.location.search.substr(1).match(reg);  
    if (r!=null) return unescape(r[2]);  
    return null;  
}

layui.use(['layer', 'table'], function() {
	var layer = layui.layer,
		table = layui.table;
	
	var h = $(document).height()-20;
	var w = ($(document).width()-10)/2;
	
	layer.load(0, {shade: false});
	
	table.render({
		elem: '#table1',
		page: true,
		limit: 20,
		height: h,
		cols: [[
			{field: 'member', title: '获奖人员', width: w, align: 'center'},
			{field: 'place', title: '获奖名次', width: w, align: 'center'},
		]],
		url: '../api/award.jsp?type=getbyid&id='+getUrlParam("id"),
		done: function() {
			layer.closeAll();
		}
	});
	
});
