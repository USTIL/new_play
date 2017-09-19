<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.liushu.play.*" %>
<%@ include file="../conf/mysql.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String type = request.getParameter("type");
String msg = "error";
//根据比赛id得到获奖信息
if (type.equals("getbyid")) {
	response.setContentType("text/json");
	String mpage = request.getParameter("page");
	String limit = request.getParameter("limit");
	String id = request.getParameter("id");
	AwardAction award = new AwardAction(mysqlUser, mysqlPass);
	List<Map<String, String>> rows = award.getInfoById(Integer.parseInt(id));
	long count = rows.size();
	String data = "";
	long i = 0;
	for (Map<String, String> row: rows) {
		i++;
		if (i >= (Long.parseLong(mpage)-1)*Long.parseLong(limit) && i <= Long.parseLong(mpage)*Long.parseLong(limit)) {
			data += "{";
			data += "\"member\":\""+row.get("member")+"\",\"place\":\""+row.get("place")+"\"";
			data += "},";
		}
	}
	if (data != "") {
		data = data.substring(0, data.length()-1);
	}
	msg = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":["+data+"]}";
}
//得到待审核信息
if (type.equals("getSh")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		response.setContentType("text/json");
		String mpage = request.getParameter("page");
		String limit = request.getParameter("limit");
		String id = request.getParameter("id");
		AwardAction award = new AwardAction(mysqlUser, mysqlPass);
		List<Map<String, String>> rows = award.getSh();
		long count = rows.size();
		String data = "";
		long i = 0;
		for (Map<String, String> row: rows) {
			i++;
			if (i >= (Long.parseLong(mpage)-1)*Long.parseLong(limit) && i <= Long.parseLong(mpage)*Long.parseLong(limit)) {
				PlayAction aa = new PlayAction(mysqlUser, mysqlPass);
				Map<String, String> play = aa.getInfoById(Integer.parseInt(row.get("up_id")));
				data += "{";
				data += "\"id\":\""+row.get("id")+"\",\"title\":\""+play.get("title")+"\",\"member\":\""+row.get("member")+"\",\"place\":\""+row.get("place")+"\"";
				data += "},";
			}
		}
		if (data != "") {
			data = data.substring(0, data.length()-1);
		}
		msg = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":["+data+"]}";
	} else {
		msg = "非法操作";
	}
}
//删除获奖信息
if (type.equals("delete")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		String id = request.getParameter("id");
		AwardAction award = new AwardAction(mysqlUser, mysqlPass);
		if (award.delete(Integer.parseInt(id))) {
			msg = "success";
		} else {
			msg = "fail";
		}
	} else {
		msg = "非法操作";
	}
}
//通过审核
if (type.equals("pass")) {
	String adminUser = (String)session.getAttribute("adminUser");
	if (adminUser != null && adminUser != "") {
		String id = request.getParameter("id");
		AwardAction award = new AwardAction(mysqlUser, mysqlPass);
		if (award.pass(Integer.parseInt(id))) {
			msg = "success";
		} else {
			msg = "fail";
		}
	} else {
		msg = "非法操作";
	}
}
//添加获奖
if (type.equals("addaward")) {
	String up_id = request.getParameter("up_id");
	String user_id = request.getParameter("user_id");
	String member = request.getParameter("member");
	String place = request.getParameter("place");
	if (member == "" || place == "") {
		msg = "null";
	} else {
		AwardAction award = new AwardAction(mysqlUser, mysqlPass);
		if (award.add(Integer.parseInt(up_id), Integer.parseInt(user_id), Integer.parseInt(place), member)) {
			msg = "success";
		} else {
			msg = "fail";
		}
	}
}
response.getWriter().println(msg);
%>