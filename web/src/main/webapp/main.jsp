<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
<style>
.main{width:100%; height : 300px; background-color:lightblue;color:white; font-size:50px;
}
input[type=button]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;position:}
input[type=submit]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;position:}
.box{
position: absolute; right: 50px;
}
</style>
</head>
<body>
<%@ page import ="web.*" %>
	<%
		String id = (String)session.getAttribute("id");
	
		FormDB mdao = new FormDB();
		FormBoard oldMB = mdao.getFormBoard(id);
	%>

<%
// 로그인 하지 않았을 때 보여지는 화면
if (id == null){
	%>
	<h2>로그인 해주세요</h2><br><br><br><br>
	<div class="main">Blog</div><br><br><br><br>
	<input type = "button" value="회원가입" onClick="window.location='form_write.jsp'"/>
	<input type = "submit" value="로그인" onClick="window.location='login.jsp'"/>
<%// 로그인이 되어 있는 상태에서 보여주는 화면
}

else{ %>
<h2><%=oldMB.getName() %>님 환영합니다.</h2><br><br><br><br>
<div class="main"><%=oldMB.getName() %>'s Blog</div><br><br><br><br>
<form name ="boardform" method="post" action="loginAction.jsp">
<input type="button" value ="회원정보" onClick="window.location='form_write.jsp'"/>
<input type = "button" value="게시판" onClick="window.location='showBoard.jsp'"/>
<input type = "button" value="로그아웃" onClick="window.location='logoutAction.jsp'"/>
</form>
<%} %>

</body>
</html>