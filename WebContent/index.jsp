<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="conf/mysql.jsp" %>
<%
PlayAction play = new PlayAction(mysqlUser, mysqlPass);
List<Map<String, String>> rows = play.getAll();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>获奖展示系统</title>
</head>
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="js/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="js/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="js/css/index/css.css" />
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">获奖展示系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="javascript:home()">主页</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
      <%
      Set<String> years = new HashSet<String>();
      for (Map<String, String> row: rows) {
    	  String date = row.get("date");
    	  String[] dates = date.split("-");
    	  years.add(dates[0]);
      }
      for (String year: years) {
    	  
      
      %>
        <li class="layui-nav-item">
          <a class="" href="javascript:;"><%= year %>年获奖展示</a>
          <dl class="layui-nav-child">
          <%
          for (Map<String, String> row: rows) {
	    	  String date = row.get("date");
	    	  String[] dates = date.split("-");
	    	  if (dates[0].equals(year)) {
    	  %>
            <dd><a href="javascript:showAward(<%= row.get("id") %>)"><%= row.get("title") %></a></dd>
			<%}
	      } %>
          </dl>
        </li>
      <%} %>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <iframe src="" id="fra"></iframe>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © USTIL 获奖展示系统
  </div>
  

</div>
</body>
<script type="text/javascript" src="js/js/index/js.js"></script>
</html>