<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="../conf/mysql.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String msg = "error";
if (type.equals("admin")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if (username == null || username == "" || password == null || password == "") {
		msg = "null";
	} else {
		AdminAction admin = new AdminAction(mysqlUser, mysqlPass);
		if (admin.verify(username, password)) {
			session.setAttribute("adminUser", username);
			msg = "success";
		} else {
			msg = "fail";
		}
	}
}
response.getWriter().println(msg);
%>