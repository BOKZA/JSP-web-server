<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 작성</title>
<style>
table, td, th{background-color:#eee; padding:10px;}
th{text-align:left;}
table{border-collapse:collapse;}
h2, h4{text-align:center;}
input[type=button]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;position:}
input[type=reset]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;}
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
	if(document.boardform.pwd.value==""){
		alert("비밀번호를 입력해주세요!");
		document.boardform.pwd.focus();
		return;
	}
	if(document.boardform.subject.value==""){
		alert("제목을 입력해주세요!");
		document.boardform.subject.focus();
		return;
	}
	document.boardform.menu.value="insert";
	document.boardform.submit();
	
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
<%@ page import ="web.BoardRecord" %>
<%@ page import ="web.BoardTableDB" %>


<%
String name="";
String subject="";
String content="";
String header = "글등록";
int hits = 0;
String smallheader = "비밀번호는 글 등록후에 수정/삭제시에 필요";

String snum = request.getParameter("num");
if(snum != null){
	int num = Integer.parseInt(snum);
	BoardTableDB tabledb = new BoardTableDB();
	BoardRecord brecord = tabledb.getBoardRecord(num);
	name= brecord.getName();
	subject=brecord.getSubject();
	content=brecord.getContent();
	hits=brecord.getHits() +1;
	brecord.setHits(hits);
	tabledb.updateDB(brecord);
	header = "글 읽기";
	smallheader="작성자에 한해서 비밀번호 입력후에 수정/삭제 가능";
}
%>

<h2>Blog</h2>
<center>
<h2>게시판 <%=header %></h2>
<h4><%=smallheader %></h4>

<form name ="boardform" method="post" action="process.jsp">
	<input type="hidden" name ="menu" value="insert">
	<input type="hidden" name ="num" value=<%=snum %>>
	<input type="hidden" name ="hits" value=<%=hits %>>
	<table>
	<tr>
	<td> 제목</td><td><input type="text" name="subject" value="<%=subject %>"></td>
	<td>조회수 </td><td><%=hits %></td>
	<%if (snum == null){ %>
	<td>&nbsp작성자</td><td><input type="text" name="name"></td>
	<%} 
	else { %>
		<td>작성자 </td> <td><%=name %></td>
	<% } %>
	<td>비밀번호 </td> <td><input type="password" name="pwd"></td>
	</tr>
	<tr>
	<td>내용 </td> <td colspan="7"><textarea name="content" rows="20%" cols="116%">
	<%=content %></textarea>
	</td></tr>
	</table>
	<br>
	<%if (snum == null){ %>
	<div class="box">
	<input type="button" value="등록" onClick="insertcheck()">
	<%} else{ %>
	<input type="button" value="수정" onClick="updatecheck()">
	<input type="button" value="삭제" onClick="deletecheck()">
	<%} %>
	<input type="button" value="목록보기" onClick="location.href='showBoard.jsp'">
	<input type="reset" value="취소">
	</div>
</form>
</center>
</body>
</html>