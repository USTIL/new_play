<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
String adminUser = (String)session.getAttribute("adminUser");
if (adminUser == null || adminUser == "") {
	response.sendRedirect("login.html");
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>后台管理</title>
</head>
<script type="text/javascript" src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../js/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="../js/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="../js/css/admin/css.css" />
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">后台管理</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="javascript:plays()">比赛管理</a></li>
      <li class="layui-nav-item"><a href="javascript:users()">用户管理</a></li>
      <li class="layui-nav-item"><a href="javascript:admins()">管理员管理</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
           <%= session.getAttribute("adminUser") %>
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">修改密码</a></dd>
          <dd><a href="../api/admin.jsp?type=exit">退出</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">菜单</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:addPlay()">添加比赛</a></dd>
            <dd><a href="javascript:addAdmin()">添加管理员</a></dd>
            <dd><a href="javascript:shList()">待审核列表</a></dd>
          </dl>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <iframe src="" id="fra"></iframe>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © 2017 后台管理
  </div>
  

</div>
</body>
<script type="text/javascript" src="../js/js/admin/js.js"></script>
</html>