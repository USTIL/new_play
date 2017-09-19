<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="../conf/mysql.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String msg = "error";
//得到所有管理员
if (type.equals("getAll")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		response.setContentType("text/json");
		String mpage = request.getParameter("page");
		String limit = request.getParameter("limit");
		AdminAction admin = new AdminAction(mysqlUser, mysqlPass);
		List<Map<String, String>> rows = admin.getAll();
		long count = rows.size();
		String data = "";
		long i = 0;
		for (Map<String, String> row: rows) {
			i++;
			if (i >= (Long.parseLong(mpage)-1)*Long.parseLong(limit) && i <= Long.parseLong(mpage)*Long.parseLong(limit)) {
				data += "{";
				data += "\"id\":\""+row.get("id")+"\",\"username\":\""+row.get("username")+"\",\"name\":\""+row.get("name")+"\"";
				data += "},";
			}
		}
		data = data.substring(0, data.length()-1);
		msg = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":["+data+"]}";
	} else {
		msg = "非法操作";
	}
}
//添加管理员
if (type.equals("addadmin")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		AdminAction admin = new AdminAction(mysqlUser, mysqlPass);
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		if (username == "" || username == null || password == "" || password == null || name == "" || name == null) {
			msg = "null";
		} else {
			if (admin.add(username, password, name)) {
				msg = "success";
			} else {
				msg = "error";
			}
		}
	} else {
		msg = "非法操作";
	}
}
//删除管理员
if (type.equals("delete")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		String id = request.getParameter("id");
		AdminAction admin = new AdminAction(mysqlUser, mysqlPass);
		if (admin.delete(Integer.parseInt(id))) {
			msg = "success";
		} else {
			msg = "fail";
		}
	} else {
		msg = "非法操作";
	}
}
if (type.equals("exit")) {
	session.setAttribute("adminUser", "");
	session.setAttribute("adminUserName", "");
	response.sendRedirect("../admin/login.html");
	msg = "success";
}
response.getWriter().println(msg);
%>