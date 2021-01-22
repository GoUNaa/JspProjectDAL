<%@page import="javafx.scene.control.Alert"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
MemberBean mb = new MemberBean();

String id =(String)session.getAttribute("id");




%>	
<form action = "deletePro.jsp" method="post">
<%=id %>님  <br>회원 탈퇴를 위해 비밀번호를 입력해 주세요 <Br>
<input type="text" name ="pass">	
<input type="submit" value="탈퇴">
</form>	
</body>
</html>