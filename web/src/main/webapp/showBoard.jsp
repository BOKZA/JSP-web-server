<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
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
input[type=submit]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;
}
input[type=button]{width:100px; height:30px; background-color:#eee;
border:none;right: 50px;}
.box{
position: absolute; right: 50px;
}
</style>
</head>
<body>
<%@page import="java.util.ArrayList, java.text.SimpleDateFormat, web.BoardRecord" %>

<h2>Blog</h2>
<h2>게시판 글 목록</h2>
<jsp:useBean id="boardDB" class="web.BoardTableDB" scope="page"/>
<%
	ArrayList<BoardRecord>boardList = boardDB.getList();
	int listsize=boardList.size();
	if(listsize>=0){
%>
<table>
<thead><tr><th> 번호 </th><th> 제목 </th><th> 조회수 </th>
<th> 작성자 </th><th> 등록일(시각)</th></tr></thead>
<tbody>
<%
	SimpleDateFormat simpledf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
	for (BoardRecord board: boardList){
%>
<tr>
<td><%= board.getNum() %></td>
<td><a href="writeBoard.jsp?num=<%=board.getNum() %>"><%=board.getSubject() %></a></td>
<td><%=board.getHits() %></td>
<td><%=board.getName() %></td>
<td><%=simpledf.format(board.getRegdate()) %></td>
</tr>
<% } %>
</tbody>
</table>
<%} %>
<br><br>
<form name="write" method="post" action="writeBoard.jsp">
<div class="box">
<input type="submit" value="새글 작성하기">
<input type="button" value="메인" onClick="window.location='main.jsp'">
</div>
</form>
</body>
</html>