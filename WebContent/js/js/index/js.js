layui.use('element', function(){
   var element = layui.element;
   $('#fra').attr('src', 'son/home.html');
});

function home() {
	$('#fra').attr('src', 'son/home.html');
}

function reg() {
	$('#fra').attr('src', 'son/addUser.html');
}

function showAward(id) {
	$('#fra').attr('src', 'son/award.html?id='+id);
}






