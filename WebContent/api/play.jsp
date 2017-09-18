<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="../conf/mysql.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String msg = "error";
//管理员权限获取所有比赛
if (type.equals("getAlladmin")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		response.setContentType("text/json");
		String mpage = request.getParameter("page");
		String limit = request.getParameter("limit");
		PlayAction play = new PlayAction(mysqlUser, mysqlPass);
		List<Map<String, String>> rows = play.getAll();
		long count = rows.size();
		String data = "";
		long i = 0;
		for (Map<String, String> row: rows) {
			i++;
			if (i >= (Long.parseLong(mpage)-1)*Long.parseLong(limit) && i <= Long.parseLong(mpage)*Long.parseLong(limit)) {
				data += "{";
				data += "\"id\":\""+row.get("id")+"\",\"title\":\""+row.get("title")+"\",\"cont\":\""+row.get("cont")+"\",\"date\":\""+row.get("date")+"\"";
				data += "},";
			}
		}
		data = data.substring(0, data.length()-1);
		msg = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":["+data+"]}";
	} else {
		msg = "非法操作";
	}
}
//管理员权限添加比赛信息
if (type.equals("addplay")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		PlayAction play = new PlayAction(mysqlUser, mysqlPass);
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		String date = request.getParameter("date");
		if (title == "" || title == null || cont == "" || cont == null || date == "" || date == null) {
			msg = "null";
		} else {
			if (play.add(title, cont, date)) {
				msg = "success";
			} else {
				msg = "error";
			}
		}
	} else {
		msg = "非法操作";
	}
}
response.getWriter().println(msg);
%>