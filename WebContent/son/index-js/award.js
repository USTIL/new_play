// JavaScript Document
function getUrlParam(name){   
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");  
    var r = window.location.search.substr(1).match(reg);  
    if (r!=null) return unescape(r[2]);  
    return null;  
}

$.post('../api/play.jsp?type=getTitleById', {
	id: getUrlParam("id")
}, function(title) {
	$('#leg').html(title);
})

layui.use(['layer', 'table'], function() {
	var layer = layui.layer,
		table = layui.table;
	
	var h = $(document).height()-100;
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

function addAward() {
	layui.use('layer', function() {
		var layer = layui.layer;
		layer.open({
			type: 1,
			title: '提交获奖审核',
			area: ['500px', '230px'],
			content: $('#add')
		});
	});
}

function sendAward() {
	layui.use('layer', function() {
		var layer = layui.layer;
		var member = $('#member').val();
		var place = $('#place').val();
		if (member == "" || place == "") {
			layer.msg('获奖成员和获奖名次不能为空');
		} else {
			$.post('../api/award.jsp?type=addaward', {
				up_id: getUrlParam("id"),
				user_id: 1,
				member: member,
				place: place
			}, function(data) {
				if (data.indexOf("null") >= 0) {
					layer.msg('获奖成员和获奖名次不能为空');
				} else if (data.indexOf("fail") >= 0) {
					layer.msg('禁止重复提交', {icon:2});
				} else if (data.indexOf("error") >= 0) {
					layer.msg('提交失败,请重试', {icon:2});
				} else if (data.indexOf("success") >= 0) {
					layer.msg('提交成功', {icon:1});
				}
			})
		}
	});
}
