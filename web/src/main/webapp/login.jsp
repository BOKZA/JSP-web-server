<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
table {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: left;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  margin: 20px 10px;
}
 th {
  width: 150px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #eee;
}
td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
input[type=button]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;}
input[type=reset]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;}
.box{
position: absolute; right: 50px;
}
input[type=submit]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;
}</style>
<script>
function loginCheck(){
	if(document.boardform.pwd.value==""){
		alert("비밀번호를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	if(document.boardform.id.value==""){
		alert("아이디를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	document.boardform.menu.value="login";
	document.boardform.submit();
}</script>
<meta charset="UTF-8">
<title>JSP 예제: login.html</title>
</head>
<body>
<%
		String id = null;
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}
String snum = request.getParameter("num");
// 로그인 하지 않았을 때 보여지는 화면
if (id == null){
	%>
	<h2>Blog</h2>
	<center>
<h2>로그인</h2>
<form name ="boardform" method="post" action="loginAction.jsp">
<table>
<tr><th>아이디: </th><th><input type="text" name="id"></th></tr>
<tr><th>암호: </th><th><input type="password" name="pwd"></th></tr>
</table>

<input type = "submit" value="로그인" onClick="loginCheck()"/>
<input type = "button" value="회원가입" onClick="window.location='form_write.jsp'"/>
<input type = "reset" value="다시입력">
</form>

<%// 로그인이 되어 있는 상태에서 보여주는 화면
}else{ %>
<h2>회원정보</h2>
<form name ="boardform" method="post" action="loginAction.jsp">
<input type="button" value ="회원정보" onClick="window.location='form_write.jsp'"/>
<input type = "button" value="게시판" onClick="window.location='showBoard.jsp'"/>
<input type = "button" value="로그아웃" onClick="window.location='logoutAction.jsp'"/>
</form>
<%} %>
</center>
</body>
</html>