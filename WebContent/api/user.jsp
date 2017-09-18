<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="../conf/mysql.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String msg = "error";
if (type.equals("exit")) {
	session.setAttribute("userUser", "");
	response.sendRedirect("../index.jsp");
	msg = "success";
}
response.getWriter().println(msg);
%>