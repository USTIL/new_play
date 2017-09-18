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
response.getWriter().println(msg);
%>