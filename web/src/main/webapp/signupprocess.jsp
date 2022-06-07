<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<jsp:useBean id = "brecord" class="web.FormBoard" scope="page"/>
<jsp:useBean id = "btabledb" class="web.FormDB" scope="page"/>
<%@ page import ="web.*" %>
<%
	String userid = (String)session.getAttribute("id");
	FormDB mdao = new FormDB();
	FormBoard oldMB = mdao.getFormBoard(userid);
	//FormBoard의 id가 있는 getFormBoard에 있는 정보를 가져온다.
%>
<%
request.setCharacterEncoding("utf-8");
String menu = request.getParameter("menu");
//form_write에서 menu값을 가져온다.
if(menu.equals("update")|| menu.equals("delete")){
	//menu 값이 update 또는 delete일때
	String userpwd = oldMB.getPwd();
	int tnum = oldMB.getNum();
	if(btabledb.isEqualPwd(userid, userpwd)){
	%> <script>alert("비밀번호가 틀립니다!");
	history.go(-1);</script>
	<% }
	else{
		if(menu.equals("delete")) {btabledb.deleteDB(userid);
		response.sendRedirect("logoutAction.jsp");}
		else if (menu.equals("update")){
		%>
		<jsp:setProperty name="brecord" property="name"/>
		<jsp:setProperty name="brecord" property="pwd"/>
		<jsp:setProperty name="brecord" property="phone"/>
		<jsp:setProperty name="brecord" property="email"/>
		<jsp:setProperty name="brecord" property="birth"/>
		
		<% btabledb.updateDB(brecord);
			response.sendRedirect("main.jsp");}
		}
} 
else if (menu.equals("insert")){
		%>
		<jsp:setProperty name="brecord" property="name"/>
		<jsp:setProperty name="brecord" property="id"/>
		<jsp:setProperty name="brecord" property="pwd"/>
		<jsp:setProperty name="brecord" property="phone"/>
		<jsp:setProperty name="brecord" property="email"/>
		<jsp:setProperty name="brecord" property="birth"/>
		<%
		btabledb.insertDB(brecord);
		response.sendRedirect("main.jsp");
}
		%>
</body>
</html>