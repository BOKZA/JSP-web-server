<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<jsp:useBean id = "brecord" class="web.BoardRecord" scope="page"/>
<jsp:useBean id = "btabledb" class="web.BoardTableDB" scope="page"/>
<%
request.setCharacterEncoding("utf-8");
String menu = request.getParameter("menu");
if(menu.equals("update")|| menu.equals("delete")){
	String snum = request.getParameter("num");
	String pwd = request.getParameter("pwd");
	int tnum = Integer.parseInt(snum);
	if(!btabledb.isEqualPwd(tnum, pwd)){
	%> <script>alert("비밀번호가 틀립니다!");
	history.go(-1);</script>
	<% }
	else{
		if(menu.equals("delete")) {btabledb.deleteDB(tnum);}
		else if (menu.equals("update")){
		%>
		<jsp:setProperty name="brecord" property="num"/>
		<jsp:setProperty name="brecord" property="hits"/>
		<jsp:setProperty name="brecord" property="subject"/>
		<jsp:setProperty name="brecord" property="content"/>
		
		<% btabledb.updateDB(brecord);}
			response.sendRedirect("showBoard.jsp");
		}
} else if (menu.equals("insert")){
		%>
		<jsp:setProperty name ="brecord" property="pwd"/>
		<jsp:setProperty name ="brecord" property="name"/>
		<jsp:setProperty name ="brecord" property="subject"/>
		<jsp:setProperty name ="brecord" property="content"/>
		<%
		btabledb.insertDB(brecord);
		response.sendRedirect("showBoard.jsp");
		}
		%>


</body>
</html>