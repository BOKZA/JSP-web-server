<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 작성</title>
<style>
table, td, th{background-color:#eee; padding:10px; margin:0 auto;}
th{text-align:left;}
table{border-collapse:collapse;}
h2, h4{text-align:center;}
input[type=button]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;position:}
input[type=reset]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;position:}
.box{
position: absolute; right: 50px;
}
</style>
<script>
function deletecheck(){
	if(document.boardform.pwd.value==""){
		alert("비밀번호를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	result = confirm("확인! 삭제하겠습니다?");
	if(result){
		document.boardform.menu.value="delete";
		document.boardform.submit();
		}
		else return;
}

function insertcheck(){
	if(document.boardform.name.value==""){
		alert("이름을 입력해주세요!");
		document.boardform.name.focus();
		return;
	}
	if(document.boardform.id.value==""){
		alert("아이디를 입력해주세요!");
		document.boardform.id.focus();
		return;
	}
	if(document.boardform.pwd.value==""){
		alert("비밀번호를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	if(document.boardform.phone.value==""){
		alert("전화번호를 입력해주세요!");
		document.boardform.phone.focus();
		return;
	}
	if(document.boardform.email.value==""){
		alert("이메일을 입력해주세요!");
		document.boardform.email.focus();
		return;
	}
	if(document.boardform.birth.value==""){
		alert("생일을 입력해주세요!");
		document.boardform.birth.focus();
		return;
	}
	document.boardform.menu.value="insert";
	document.boardform.submit();
	alert("회원가입 되었습니다.");
	
}

function updatecheck(){
	if(document.boardform.pwd.value==""){
		alert("비밀번호를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	document.boardform.menu.value="update";
	document.boardform.submit();
	
}
</script>
</head>
<body>
<%@ page import ="web.FormDB" %>
<%@ page import ="web.FormBoard" %>
<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String id = (String)session.getAttribute("id");
	FormDB mdao = new FormDB();
	FormBoard oldMB = mdao.getFormBoard(id);
	//FormDB의 getFormBoard 함수를 불러온다.
	
	String name="";
	String phone="";
	String email="";
	String birth="";
	String header = "회원가입";

String snum = request.getParameter("num");
if(snum != null){
	int num = Integer.parseInt(snum);
	name= oldMB.getName();
	id=oldMB.getId();
	phone=oldMB.getPhone();
	email=oldMB.getEmail();
	birth=oldMB.getBirth();
}
%>



<form name ="boardform" method="post" action="signupprocess.jsp">
	<input type="hidden" name ="menu" value="insert">
	<input type="hidden" name ="num" value=<%=snum %>>
	<table>
	<%if (id == null){ %>
<h2>회원가입 </h2>
	<tr>
	<td> 이름</td><td><input type="text" name="name" value="<%=name %>"></td>
	</tr><tr>
	<td>아이디 </td><td><input type="text" name="id"></td>
	</tr>
	<tr>
	<td>비밀번호 </td> <td><input type="password" name="pwd"></td>
	</tr><tr>
	<td>전화번호 </td> <td><input type="text" name="phone"></td>
	</tr><tr>
	<td>이메일</td><td><input type="email" name="email"></td>
	</tr>
	<tr>
	<td>생일</td><td><input type="date" name="birth"></td>
	</tr><tr>
	<%} 
	else { %>
	<h2>회원정보 </h2>
	<td> 이름</td><td><input type="text" name="name" value="<%=oldMB.getName() %>"></td>
	</tr><tr>
	<td>아이디 </td><td><input type="text" name="id" value="<%=oldMB.getId()%>"></td>
	</tr>
	<tr>
	<td>비밀번호 </td> <td><input type="password" name="pwd"></td>
	</tr><tr>
	<td>전화번호 </td> <td><input type="text" name="phone" value="<%=oldMB.getPhone()%>"></td>
	</tr><tr>
	<td>이메일</td><td><input type="email" name="email" value="<%=oldMB.getEmail()%>"></td>
	</tr>
	<tr>
	<td>생일</td><td><input type="date" name="birth" value="<%=oldMB.getBirth()%>"></td>
	</tr><tr>
	<%}%>
	</tr>
	</table>
	<br>
	<div class="box">
	<%if (id == null){ %>
	<input type="button" value="등록" onClick="insertcheck()">
	<%} else{ %>
	<input type="button" value="수정" onClick="updatecheck()">
	<input type="button" value="탈퇴하기"  onClick="deletecheck()">
	<%} %>
	<input type="button" value="메인" onClick="location.href='main.jsp'">
	<input type="reset" value="취소">
	</div>
</form>
</body>
</html>